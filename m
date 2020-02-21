Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA5B16882C
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2020 21:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBUURi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Feb 2020 15:17:38 -0500
Received: from mail-eopbgr1300135.outbound.protection.outlook.com ([40.107.130.135]:54592
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbgBUURh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Feb 2020 15:17:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5PXGp2L/y2v2rZxLVAZh5Z3gx0HY0sQXUExDn1YC5TWWy/TxfUoVECrQS492/ET2ADIUhKfOn47BQIme9XNCgvAx5Ims7w1HoUuv3hh8gDAtnbXBTi5OaQITCguQ05/2RzDdyPBOoit7flOFoJqMW6JUdhV7Srox6iNyDAPUlT47jHFCc50fNkYa7L4p6PqO2WWCYILCW95YmtDu/UoaAMJO9b5CBkaiqDRv/LG7v/Qj/miFQz4iimTLKlY3slvYZlOZkk53WMDZG1DmvoadvklGNsvlWLRxFk3lMwHc+KKNBfXtAuYOdsy3bLw5Rd4hiaoGuNBcNscpygoMnXs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFbyesmyoIJ0fQqCx4h6y6Y8fHL39vGTNpu9E0gi/5E=;
 b=SdHDMbTEKo9BSnhb0QfHb1foQaHN3vpa/IKKMbxODRrmTsLFSRSwPpvP9d/DaC7eypvZkBU1Ur+V4nZeLQtQOtGI7gjAlBsYxaNcQa61TuzM33ekjiyHLCQcbh9qcPcDtEnpl67y+bVDOhie4ipZ4j95npPY924KXy8PGQLf+wAmjyKmp/hmhpIfn0m6nBwWSeyy3MdlyYBb40EgJ63wGwXXpQT/S7k/Gp4JqV6NF8mXomSEUzHNy5dcQCjnpJeeQTCFC2JOjn6EZspwG06Kg7GmxYqioWhcM6LcLgXyULb1vTt5eYbseo9AqbGkaVmNtMvs7A0uVFp9KkKJXXBxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFbyesmyoIJ0fQqCx4h6y6Y8fHL39vGTNpu9E0gi/5E=;
 b=S0zW8WjhJye+tyEhHggt5LiKpqE9aTEyzNpQfrO16lBe2/GYIE9UHt5cQVT63hffGiQJbKwSzaXNmm8Aq/t04uCSDjmBK3n5PZhy/jjf1X55bOtSbH7H7A9QZZ8Y/LHTNo+2EaGYs82EnT5KIqCkZiTZ6UC70zhbAOoBYBJjP6Y=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0259.APCP153.PROD.OUTLOOK.COM (52.132.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.4; Fri, 21 Feb 2020 20:17:29 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::a02a:44fa:5f1:dd74]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::a02a:44fa:5f1:dd74%2]) with mapi id 15.20.2772.009; Fri, 21 Feb 2020
 20:17:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Use kfree(hbus) in hv_pci_probe()'s error
 handling path
Thread-Topic: [PATCH] PCI: hv: Use kfree(hbus) in hv_pci_probe()'s error
 handling path
Thread-Index: AQHV6MTTYxxTTdKrHUimkreM9jFb+KgmFYKw
Date:   Fri, 21 Feb 2020 20:17:28 +0000
Message-ID: <HK0P153MB014824764A8F7310502291C3BF120@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <1578350351-129783-1-git-send-email-decui@microsoft.com>
 <20200221144003.GD15440@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200221144003.GD15440@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-21T20:17:26.4167793Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e05456d8-ca32-4dfc-a11c-32be868d8b4c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:44ce:5ee7:dfaf:44c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff8b8168-fba2-4216-cae6-08d7b70b130f
x-ms-traffictypediagnostic: HK0P153MB0259:|HK0P153MB0259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB02595DF50C1B38F6EC1DE061BF120@HK0P153MB0259.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(189003)(199004)(107886003)(478600001)(4744005)(4326008)(55016002)(66446008)(6506007)(54906003)(8990500004)(66946007)(66476007)(5660300002)(316002)(66556008)(76116006)(64756008)(9686003)(52536014)(8676002)(81166006)(7696005)(8936002)(33656002)(81156014)(186003)(6916009)(86362001)(2906002)(71200400001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0259;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GLj/Ivn0+dmTLfywiL6bYIP2Bpt7GtoZEy7Xv1Ap17Wx+CRhFO/Syh7djGP44pFjy8f+EHABccFLQQcgoNi8EUrbfl4MwHxxF3bn86h2GcmfzpJx504ZSKlM3exUKpYx+ZoO6rNNAGUZR+cAvff8zA0GrJdUFJczxd0qNa2NeDSLcB2riH4Vs2s3dhKejIUJNuBmanHejOsTXe3Nl7QQBm98JGstkoxvuxPIjBSTAYOGtwzhNmSwJsADfUGL43myZlcx3crHHXO/tjgUfP3TL6tcWqPmOZ1VgLNsjwO1g6e7cxhrgJGuYITjDN3F8Zb7klW78tvpLMYbKkodl1KiANj1MwfSsLwLRtOZrWFEQGUEem/SSck8eGOQd8hux8l7T9eLmb6gH8QcW+9+PTCrOZmPsnHM2uWP6kXpmctqb4oXC3zmPLrVSvp650p9KiV
x-ms-exchange-antispam-messagedata: MKO3sTCnCfnPsZ3Ma7yml5CMFEI0tlH6lV/W1HYoD7ZlYk7EViObIpD/evSULijx7sVlAMBtPw1EEQMswoDlZxH1DUdDIutzMBROFv1jnh1eRilERLgQcD7+CSknFoa/WLTDL3yrT4oR5VSbpO+h9IrWwi+b7UfolbTwEPtjwpxOKCHHAVz0K3WmHVCUlFIIkqhQb5BbFw4YQ4zmunm6IA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8b8168-fba2-4216-cae6-08d7b70b130f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 20:17:28.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8IuJkXoph3AlFexd7ApdHcO0d4cIQu8H7dCqqcozwwckeSceoxvtrdC1RZ5H68NPTE8qRoN7dyOJDsxr4+zuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0259
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Lorenzo Pieralisi
> Sent: Friday, February 21, 2020 6:40 AM
>=20
> On Mon, Jan 06, 2020 at 02:39:11PM -0800, Dexuan Cui wrote:
> > Now that we use kzalloc() to allocate the hbus buffer, we should use
> > kfree() in the error path as well.
> >
> > Also remove the type casting, since it's unnecessary in C.
>=20
> Two unrelated logical changes -> two patches please, I know it is
> tempting but it is important to split logical changes into separate
> patches.
>=20
> Thanks,
> Lorenzo

Ok, will post 2 separate patches shortly.

Thanks,
-- Dexuan
