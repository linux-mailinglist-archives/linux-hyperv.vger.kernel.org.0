Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C553436A41E
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Apr 2021 04:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhDYCY7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Apr 2021 22:24:59 -0400
Received: from mail-mw2nam08on2139.outbound.protection.outlook.com ([40.107.101.139]:62313
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbhDYCY5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Apr 2021 22:24:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElUzZ1/y0qObQONQZuTyewr7GH3pAaWXCWCcfx69yRYuQW+/+FTex6O+81MhwCPLwNnCaOTAGzsytfuVqhM2RsQpeByPp2nGoezYoJS12CPLsP2Zx1Whk2pFuU8xuq56sKd58CxtWqVPgx9UcStLmN7FY1EFEq4pRSW3DlSVYpoRx1ySO7T4+pjVlWPVK+Yi5ASEqJGNKiPWgLr+NWX9GjcX+DvVJdt7Av4X2NYiWbiQqDTCQXkZKn2yQN34g5ub105AzzXb9KSS8GFaYCvXloQMKkYPNUwfpdIwjQwiPOBCTGdHdubd/7jnJniMp724yF2gjB6VX/IyIRwIs95h2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH+p9XHQ6QXcIXYN6h7A96jpHPu8qFgj/fZ/H4Wz38Y=;
 b=I/1VWOEzKjrASPoEDdqLL1UKcc2QRxL7J2Y4dbgiXTKsfNk2uyqQ0cTf8ygPycZLxq8rgkkB+CRdOeFxbTh/vHNxPStnjH/yKAYLwgtM/TZ6mt+RzYz9tffdkXw0eClyzbAI4V6b9fBT+p+zau8C02KnRHieagL7lkdfE388b2c88I8KNAuCYEeCqRv1WDmuJw5COIGb/uYaOCHXsNZpLjiSN2N/cLOnNvf8qdIIWuHPJ8PjMSoaA1Uw5KVCSqqz0V2uAZA+n7kIqqrY0GI0tun5n0ycSjvnvEJm5Oyn8qPD+u+QLeEQxTgAWR0u0lxq2C3FK7/VzO6VXy2/VKqjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH+p9XHQ6QXcIXYN6h7A96jpHPu8qFgj/fZ/H4Wz38Y=;
 b=JXLipRn/vT6Fe8y8YAsNg0kUOYanz6LcrmGdbaktZWk7C1z63zFhE8vbQNSsjhS0krhAKdTu2BI28vHf3Rj1y03sOmI3k5zgXd83cirXRRNLOCbdX9eYpoIL7iaRrVrd62Q1KvcsipqBdLijdXwclLyK/XwtLw7C7qXQQx1po9g=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MW2PR2101MB1132.namprd21.prod.outlook.com
 (2603:10b6:302:4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.9; Sun, 25 Apr
 2021 02:24:17 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%6]) with mapi id 15.20.4065.008; Sun, 25 Apr 2021
 02:24:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Topic: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Index: AQHXNzrEqHm1W7VddEiGdCJpDqqWbKrBrccwgADBxQCAAAH5cIAAAsOAgAINbcA=
Date:   Sun, 25 Apr 2021 02:24:15 +0000
Message-ID: <MW2PR2101MB0892411250C6BB554DFF38D3BF439@MW2PR2101MB0892.namprd21.prod.outlook.com>
References: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
 <MW2PR2101MB0892A9A0972199A2FF6D68B0BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <BYAPR21MB1271F9B76FAA423D7BE6DDEECE459@BYAPR21MB1271.namprd21.prod.outlook.com>
 <MW2PR2101MB0892D7E83CC44D97F4317871BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <BYAPR21MB12710349DACC3FF32CC65793CE459@BYAPR21MB1271.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB12710349DACC3FF32CC65793CE459@BYAPR21MB1271.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=825368ff-303b-448a-ba43-6f3872c68267;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-23T06:58:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:558a:c28c:a289:2529]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08a4015c-af04-4616-6f57-08d9079139a6
x-ms-traffictypediagnostic: MW2PR2101MB1132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB11320F7BF18E86819592F5F6BF439@MW2PR2101MB1132.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eg+eI4ArqHx/5L2nPrL5SMVgWv/dGeCKXnpu7f4WKAlmXqwMyjgOsF5rrNBeQ8TR+1d64tRCapd1NW+IMuyuv5grqnq0iqWb6cQ35UI8zSnxw+BgD7HQFHRUEW9MFu/X2SV5UtIxNRca8SPu+Z+uxpMwvzOW6zxkXycXP0c0jTm3HKVLwt8gT97DXVdqVWEq/B20b8hKw5LanItHqxN5LlMN+/aNCTc+r5yi6Rrr5SGNQw+ZhnU0c+6MsaDCtVXfleBWlPDJXoIs3F398BRIZre+KuPYRuGN/eyJDLe11mSRjzMG2Tlq5Q0sWi0yQndAcmDym0GS2sW9lORuDpfgGjBOgpeESPXgp7GUX/awmknFAEild4+N7bIve57CRCF1POCS/S5xmrqrCIPEK1rY9B8xwk9+RFn+t4MVCGmc/ClpXxOIxvKib9jfcuFsK/Wc6PLsOhfgPHGQXjA0L0BwbPkBPtZga9W3nHSRL0T3EN9kryUKRCJFyV9C/NtQlw1t0h2t92LKA/deh7egqAip72ca+OqbS6Sez/6KGEduSoj3bayDE/Mk3rtp9ApQ0J3ZnlsNP55o/hp2addNGrvUugLYW8Z+fEqxe30Cz96Pj7X1MFQi5gK4pJKUHptYRvpXu3wk7IWGA8mWOJc9oNU3dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66476007)(186003)(66946007)(76116006)(110136005)(6506007)(53546011)(83380400001)(10290500003)(478600001)(64756008)(9686003)(52536014)(8990500004)(66446008)(7696005)(316002)(921005)(2906002)(66556008)(5660300002)(38100700002)(86362001)(122000001)(82950400001)(8936002)(55016002)(82960400001)(33656002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pIsgAEImfESAuKR9kbBaV4Ba7V0X/iGgHM3CwxrgzGK3TUgf6Dueu4GLQkzg?=
 =?us-ascii?Q?hPhHqqDPQg6yTZr8gOAqEmsV0BSVQQ/nsUEivzJQ5/UTNGj80zaZHGvPnjgi?=
 =?us-ascii?Q?WSaokZFm8cdFJh9cBeiLE5cIGg5YFh5h3Uuy3p28ra01i0r/6bsdNqSS59XJ?=
 =?us-ascii?Q?0IaiTwRH8jD0cQYwREFVfaHkEb/hThaw1sI96Ij5wmW7rsK8pPI8BZRfu0IT?=
 =?us-ascii?Q?M5Y1kDurD9lgOGR2nzozpfpwkc5j1wK/tlsLwVJk/bSK2iC2pKrK/nQyvDhd?=
 =?us-ascii?Q?2AIrg1C2Z1EdQQQzazxkJZGHTF7U5LqQ/QT0BLpAoyKlj6JJ14HcP9SMz3Dw?=
 =?us-ascii?Q?5g94fFtrpuj9POv3C50kT6hfh/tnZnchk0rs8kBq4XzM+++0FpQnklIcVrhp?=
 =?us-ascii?Q?pZGCH3I1N+mf6RB5sLGpnvm1AteCVqemUr7DdPtgRICgHATlA6dx+45dWJUv?=
 =?us-ascii?Q?KPS/FC+GgFqyJG0hzid39gUFM78S3Dz+YyXXpDiL3CAom0RuRvluQBupbAgU?=
 =?us-ascii?Q?t9hboS3BrjscEmncpdfzLtGktqT00DYIxIEMoGVtGA4ot3++/+jXom2NDuig?=
 =?us-ascii?Q?1HTWHD0c7zeMeTyv4XZXwmzhvSIjyT6nHbnSF1vvWQ+gbtfY997zPUvmX5Mr?=
 =?us-ascii?Q?pkDz0uy/haX504hsvhh4A48B3rXeW1Ub6cglNNavMvfqFcXfZpepwg9Gf/mb?=
 =?us-ascii?Q?yg38wUbOMpGeZ+Q3426fHy6gRasR1R95E1wE1HkUUWNsGns0pjDGjJ/UJ81l?=
 =?us-ascii?Q?MSQvRaB7VzJSkzHj4UR7eDCpyFG1PEj8KrdC/0vsuXnsxGESfwCocPMMqPht?=
 =?us-ascii?Q?L2buHeBKJ1IfHbGtKgS84L9PaGZ3Hi8s1JSNRYuxM643iFN2Qk5ffzmCXEDF?=
 =?us-ascii?Q?kGFUAbLz5iwCMPpUZIIy8kqT5V9GSWFftI3Wg6aU6lceGJ+Xtpyj6mKxbnfr?=
 =?us-ascii?Q?wpqSLfTiAUyxrgThOR6q5+nC8SFx0SyS/LY0mB3HpB6o3jnwaT8IvTolLZAk?=
 =?us-ascii?Q?dBLspKXu31PpKuRBReNncVINCVOECsx0WhJzc49qvs5s7ssJ1HEs9yB6PMkg?=
 =?us-ascii?Q?qCsbC+i2gvdkwHS9LagUfhzOSJTXYbbBZfoG0ZqgV9d29Mr6NyHBxBM30IwN?=
 =?us-ascii?Q?tRJFr7ktKtjlcEvgyKZHrPt9Wc6OnWYTfnDkvYDC7fVwyJH3cg8cagwTPkNw?=
 =?us-ascii?Q?ZhH+/0GakXYSItav0LX19Jf7JRiF6Yp9tnUo1++ntbg+KC118IX7vi65Rmdu?=
 =?us-ascii?Q?sn9FQgbE9yysXrZ1AkCP/u4y9qQ22GClSHCasx5RSJVmv9EE+jRCz2UDnCfc?=
 =?us-ascii?Q?9XLN2fnq3jCG5DamDSH5BjIeyy5p/7xGotE1Fq/SZhT+C0IGrmIBCd1TlOuz?=
 =?us-ascii?Q?28yKD+HiudHcTAMBIxcTjOTDKBHy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a4015c-af04-4616-6f57-08d9079139a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 02:24:16.7187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1f8N+LsOQZbV6tEy3Dr7no/p7DWaGAQbvnnStrkIqRl868HfGeQFZucf17b8R/RQIB+d9HbpsaUIscriFPpxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1132
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Long Li <longli@microsoft.com>
> Sent: Friday, April 23, 2021 11:49 AM
> To: Dexuan Cui <decui@microsoft.com>; longli@linuxonhyperv.com; KY
>=20
> > Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing=
 the
> > device
> >
> > > From: Long Li <longli@microsoft.com>
> > > Sent: Friday, April 23, 2021 11:32 AM
> > > > ...
> > > > If we test "rmmod pci-hyperv", I suspect the warning will be printe=
d:
> > > > hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_start_relations_work=
():
> > >
> > > In most case, it will not print anything.
> >
> > If I read the code correctly, I think the warning is printed _every tim=
e_ we
> > unload pci-hyperv.
>=20
> Okay I see what you mean. I'll remove this message.

Here we just want to avoid the message every time the pci-hyperv driver is
unloaded. We might want to see the possible message when the PCI device
is removed, but it's ok to me if the message is unconditionally removed.

The real issus with the patch is that the 'hpdev' struct is never freed whe=
n
the driver is unloaded: if we print out the value of the ref counter in
put_pcichild(), we would notice that the ref counter is still two when the
driver is unloaded, i.e. memory leak occurs.

Before the patch, hv_pci_remove() calls hv_pci_bus_exit() ->
hv_pci_start_relations_work(), and the ref counter drops to zero in
pci_devices_present_work() due to the two calls of put_pcichild().

With the patch, when the driver is unloaded, pci_devices_present_work()=20
is not scheduled, hence the ref counter doesn't drop to zero.
