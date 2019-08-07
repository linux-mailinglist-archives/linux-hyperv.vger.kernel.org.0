Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D312384FB6
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2019 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbfHGPWE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Aug 2019 11:22:04 -0400
Received: from mail-eopbgr770135.outbound.protection.outlook.com ([40.107.77.135]:37150
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387777AbfHGPWE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Aug 2019 11:22:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHbRK73aVdXpnkLjoWxWqQqCasCWj8Vijq4YmmQOZm8cN6jtzDgmiehsXuQsaqNqHzYbwuPz5Q9Vx9f4+siZPVufgqZQgZ5yut+8nvfKYh7ntJ4mJ20QwJ/3nQB7UrxzY5QpC3v0J54LYR1lwtmZutSjhCMhW7EpbxxqvbjXNQPij8RwdbaaBotxhFSQmNytuh80lJNpuPZ3XWAHHnTY9wDOqEMxqJFd3eRXW6GFpd48EfTSHJtxC0IhQz9WJn7m8fMcrYpfrhRVtynzvUkGM352mD6tjnKIoUFmepGk90O34AszYVcYFFyy2R3imZJdSD/rPbi2Wpr6F+B7AV5M4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHb6KjBggRDFLA99hJqz38/vmkQyB5AJqcSNzEmnIyk=;
 b=RrviGORrqv/EYDV90/N0h5xDhi9l7ylvxoe3SJ4Y5j1Q+BugJYyt4PpFGPYUBTu0y5gotJwSy2DRgE24MkOsMnPcCIMYUA4MlBXse40pYhz8vty+mPIcWQ2d5t4CZ9SCX9WVkOg75W4JjE58D0phQujzGewJRIesqjQCygbOqIE52NIa+vWimwZPywfU8nAM8+4SgjQxEowZKEG9HDBBePfpZFnaoshTRZ9kftqhS145jXxApe+1hcroabEoc5Hx7PL2JmlA6iLSPWyuWc5xmdj6Jd4VAi9/HWwdDyppFSN9PFOOwxtYXTmFtuHCAfinc3FZSygwQYwetCfs+AMZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHb6KjBggRDFLA99hJqz38/vmkQyB5AJqcSNzEmnIyk=;
 b=SYidCb45Qv9J/hv8fuzLBmQXfmXIyXuls0sSc8LQkGlv57x3sPQ61a5x2qVopdA7RgKFoZ5WXbtZLb5mQSF9AFuGt6EWUlCwFButItnZ4gTIekUvvubAcvKZnNwTiwMPYQs2Uf+mTZ8hKZ7fx1VGfMX0mVLWFKgSYrpD+dXe8kQ=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0748.namprd21.prod.outlook.com (10.173.172.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 7 Aug 2019 15:22:01 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd%2]) with mapi id 15.20.2157.011; Wed, 7 Aug 2019
 15:22:01 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/7] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Topic: [PATCH v2 5/7] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Index: AQHVR8iqC69kTr/0FUeTlMMLeLsZzKbv1/tA
Date:   Wed, 7 Aug 2019 15:22:01 +0000
Message-ID: <DM5PR21MB0137166316B72AAEA5EFBB78D7D40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1564595464-56520-1-git-send-email-decui@microsoft.com>
 <1564595464-56520-6-git-send-email-decui@microsoft.com>
In-Reply-To: <1564595464-56520-6-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-07T15:22:00.0847515Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=90aee59d-cbce-4bd1-9797-46eaab2b1f4c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:2e16:ac86:48d:60c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f4a5587-d66e-44d8-c7f2-08d71b4aff0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0748;
x-ms-traffictypediagnostic: DM5PR21MB0748:|DM5PR21MB0748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB07481C94490C5814AD6283B5D7D40@DM5PR21MB0748.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(6506007)(66946007)(7696005)(14444005)(186003)(229853002)(102836004)(76176011)(476003)(4326008)(86362001)(10090500001)(25786009)(10290500003)(6246003)(478600001)(446003)(2201001)(7736002)(22452003)(64756008)(6116002)(66446008)(110136005)(33656002)(46003)(8936002)(55016002)(74316002)(53936002)(4744005)(5660300002)(71190400001)(1511001)(68736007)(316002)(305945005)(9686003)(11346002)(76116006)(66476007)(14454004)(2501003)(66556008)(2906002)(71200400001)(486006)(256004)(81156014)(81166006)(8676002)(6436002)(99286004)(8990500004)(52536014)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0748;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tco1o57b/2pST1NaDCBZCKzGNRBIyPx8khSFMuXyqTKLzdYV6v0iPIrCijuhLRHcvnQ/oMIrMMEIx2QAx4XSoZS2B7g3XGHe2+BzVPIidd0zd2FYjmNgUskB3Wrj6JIqp3nYcK0+BP1Sd/XatUcc+nfCo9z0F735LY888ZgOxPHdU8wABF/eIZgz0keLlg5NSejGgV37MyXtLiJ51PJPob6ghPqkqv1TPXGkI/YsSQcNrYbL9MSO0qdsAc3JmtADI3qf1Gs0mI6uQ3s3U/Ic/PpWziRP/l1qPNEQtrkTh8OsGFYL41JjVjVU8xuwx28aWzKObDkmW0po5dP+ZqzZEBsHZMfdq6WueNfQ0SYec+yZjDg1qI1qqopD6/RqhuN2JbMfZKphJy4BaLqBs1neUlsLqGtUrIUVea+LB/e37DQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4a5587-d66e-44d8-c7f2-08d71b4aff0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 15:22:01.5936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGs3ncdOi34WEPQltMjc0hFQBJVyw/lM5buDTeO4jg0C2aBmcLa75rF9iNmMKdvP0hnQNRYTeIphEviIeb+RmC7FkFt5a4G4a/TR7vJHCc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0748
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Wednesday, July 31, 2019 10:5=
2 AM
>=20
> When the VM resumes, the host re-sends the offers. We should not add the
> offers to the global vmbus_connection.chn_list again.
>=20
> Added some debug code, in case the host screws up the exact info related =
to
> the offers.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
