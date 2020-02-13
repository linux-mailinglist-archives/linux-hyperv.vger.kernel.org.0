Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6901115B7E6
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2020 04:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgBMDnx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Feb 2020 22:43:53 -0500
Received: from mail-eopbgr1320124.outbound.protection.outlook.com ([40.107.132.124]:17747
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729515AbgBMDnx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Feb 2020 22:43:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5EHSoxBgmEvkHe0ZMDgSRyIsOFYDq7ttavonhlXl9DV53bnRNQqAWA6u5wP4QX2k4RZfb8VaAhgle/RF9HdXJIUeXMO1RzdS7akdlQy8N5kIJzH5vRwshzFAR6QfieZ9VrDfdZo0RHxMnoIEMCj7TC8W4cynPEWmts+NbS2n5xUxD6g5Tlcg2YZIcyhD+8HPWaXdKfmRUXOgrr6EU+fCFFJHhvXceiLc8H8PqoGiV2kAZ89O1WRR7t7ZkHBP5LJpBQMoH9qbFVcTEGIqRDK0sar9fnLYDGHBWjf0oWev6FaTwiOiuQ4SFUOzyLeZYwNgEwCrujDdYZIk61j8P7m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3gYpHuQ0uuFtArwD91pE95y0Kyk/Kj4d4PSaGcdKDw=;
 b=msooulSJI6F7aQUMhbkcuMzlszJQW29HpK9BdHUnP2GtLEG0j6JWa4H4lWZ+ecl3JONaQ7K/zZwDLKppSJVFCQ/tpQebjo0+R7y1mn3tZs4iDBEldtrXrnAgPXTMe7RJZtLzLYFJgVCdWAjSiPiXUzHMAuCTw8j65L0JgWWZhMyXySXAF+V9FPmsA7a9vs//ulk4ljdoqxtKrV8Rn6hqKsJ9NyviNzyKT+nCDz1risgMZq9eUlau0ZLUM9Cj9FuCrXoDseFwlZbNUsjnBetPaxRL18sgOs65HGAavGe1e4VxmE8MiA2RMoHW24HG+fibtkV5T1Rc2Yushc8mNsHz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3gYpHuQ0uuFtArwD91pE95y0Kyk/Kj4d4PSaGcdKDw=;
 b=ecwo4Nj4XufLoNr4axg32ZFPnmVQvUmgBi+8gJqQG8/ChFh3datX3yx4ua3AgpY7WQRxooZp1Yqbm07MDtKzUztz7JnJmQRk8v6xqBWqzZQR18IqvD2cmJ6hieoDxmjE62zXHgAZ1AILDiZvXjo2XseulP/ZvduBpWti/oob1Mc=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0292.APCP153.PROD.OUTLOOK.COM (52.132.236.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.2; Thu, 13 Feb 2020 03:43:41 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%5]) with mapi id 15.20.2750.007; Thu, 13 Feb 2020
 03:43:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Replace zero-length array with flexible-array
 member
Thread-Topic: [PATCH] PCI: hv: Replace zero-length array with flexible-array
 member
Thread-Index: AQHV4gsYucMpvat5UUSDAQTTiNi7uKgYdpbQ
Date:   Thu, 13 Feb 2020 03:43:40 +0000
Message-ID: <HK0P153MB0148FB68FCBAE908CA5991C3BF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <20200213005048.GA9662@embeddedor.com>
In-Reply-To: <20200213005048.GA9662@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-13T03:43:39.3474924Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d08b85ce-1d8f-49a6-889f-41446c59405c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:c129:4d3:3571:d407]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4606557a-eba4-4e46-f2fb-08d7b036eb03
x-ms-traffictypediagnostic: HK0P153MB0292:|HK0P153MB0292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB029260484E69915796A17CB7BF1A0@HK0P153MB0292.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(86362001)(316002)(81166006)(7696005)(8676002)(71200400001)(186003)(54906003)(8936002)(110136005)(81156014)(2906002)(66946007)(478600001)(4326008)(33656002)(6506007)(10290500003)(66476007)(9686003)(76116006)(66556008)(55016002)(66446008)(64756008)(5660300002)(8990500004)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0292;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSE02fdnMPCXUG62qEdDjJ0uONQgagRNo2hOKPEV/MLAE1JsEqDuADeT89ewcEjlyXpWnEXD0I5Goc7JlHVTt7+54Z5OVuwGCYBroEOxt2/8Rti0V0Zw/PkZ0soxCmrlPRdxHuneVBnvP0gagm0LcX1e1txYLPkfYyKmtZhdYgMvTJ0TIXQw5eIYMJtgWkgr2ADrRL5E6iRSMKcgT2huYfU+BKlTU5taLIFCo3K1SSu/qf4Gg/n19KqqOsWkRVTxxvDvBgdOtI7gRawXKEC6rKd63CGB/CqdwRxo7iDDKEYke4/3attlGr1ZbHqMU3FENBF/oKnELDv2HpMagXeq1IvFnW7W2ldQ0fqUL/s0xjbzda+L0g4+KhSJVuZWo0BQJrA5Kcap8+Y19kbwriLt/Ht+AZpGJ1nTC0/iiF27S7Eh7JWV6A6/rSUvBCNKGPmv
x-ms-exchange-antispam-messagedata: C6SRptTY+1NYk3NMp4rBVKap3aWX5FSM9mq8M04jH1+rnWlV+Z6tp2+Xpof7hkXhsKdlEi0gb7xMrCGErm8et+RUA22bvaPp7KZMjM4pK6i0dwxSdiy7xKg81cBGmfW4QyP09yBM+OK0QVA7I0qOWakamtVlOanTFSO+G1ZwkCh9cENu9DDsA9lkD1wSWDboEbAJvf9oHD0z6hfjbDxKUw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4606557a-eba4-4e46-f2fb-08d7b036eb03
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 03:43:40.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RB9BCpfTZOnsZXet7cJAV1ddN6XmbzFnq2MTgtrriizcK6njOEChJa+i6J9kpGHnBQuiasTCzlxfemUWFsIiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0292
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Gustavo A. R. Silva
> Sent: Wednesday, February 12, 2020 4:51 PM
>  ...
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2]=
,
> introduced in C99:
>=20
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>=20
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>=20
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>=20
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>=20
> This issue was found with the help of Coccinelle.

Looks good to me. Thanks, Gustavo!
=20
Reviewed-by: Dexuan Cui <decui@microsoft.com>

FWIW, it looks there are a lot of more to fix in the kernel tree: the below
commands return 1373 for me:

grep -nr '\[0\];$' * | grep '\.h:' | grep -v =3D | wc -l

Running the commands against the kernel/ directory returns 3.

Thanks,
-- Dexuan
