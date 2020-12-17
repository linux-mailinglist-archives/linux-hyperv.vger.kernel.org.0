Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F802DDAE1
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Dec 2020 22:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgLQVc0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Dec 2020 16:32:26 -0500
Received: from mail-bn8nam08on2121.outbound.protection.outlook.com ([40.107.100.121]:17376
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbgLQVc0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Dec 2020 16:32:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lrpn7g69a6+Bbpk+mcmydzZkwAKnH7CRcVcCANUqikdvrq930+B+c7sXwgE9W9qM/M3zdhu1kQY/znqjzLtUX4OLqYHa6NKgpkdDvbNVN5Gnif0uRN6G63R1g5im2qSUWxNJ9UzYYHnV14GNMC9NQL+voOhaxOeJJhHjreSQgZzvKgOsIo7gyrLFJqQ1WDdqmPLSDFd9xoocVeRbL6eI6kCQCguDHmbXLnaNsntRArshNOjxf3DQp8vjkbUZVcu6BKva+WM2XhwHk28y5XUKpr9G6QaHrcH8vZ1B/2LN/Ry4ULZDmJuAndkcvByug21ggQPnqC+OwR4Yy4MqNQT56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuB6dkFJUdMpOBYbhNQQZ3juxpy+pAZgkubqxVER73w=;
 b=AdHK5B/bBEL+kABKyz3vht8k2lFc6V+yt7ZaKIPf2KSe9cDmscWQDdD4uKh3Ycvo94kOjwBu+podNA/DNMxXwqIjCOzvwt2XhztGUtwwV7a3sjD6ozBFMQ/76oyi/V3pLQHmB+eNiSMvoeGKhSWOUDbctF0iQaolZe4iCLC8tYoqzVdUSR0Qml9UwoBVsEPXel0hdyxsi1mLH14rvtzD0kU39a7b70f9y/rG23M0WWmGIQRLh6HwYTYQr38hGPX7Dh3h2JlTchwx9TQGUKSAnPgCqhdOllbg6+f2eGhkK5bHfNjvo9GLXVtm6pPSUhwaNPQHfp32LlgPpFrBVC5K3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuB6dkFJUdMpOBYbhNQQZ3juxpy+pAZgkubqxVER73w=;
 b=PTra9xdWO9SSxcTRJMkcWOHQ1rAa9NGbhcCo96wJ+GU5FjGy4xzhVqMPa9dHzXo3R2MSlosVijPRul4NNmHCZe5e0pAGAVzMyEjrq27+QvvUXsCfIbY8ssXOBe9I3vGos6PYLdQlE9ehps7f/C/R8lHI0XdnDuMA/+3JT7ZPne4=
Received: from (2603:10b6:303:74::12) by
 MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.3; Thu, 17 Dec
 2020 21:31:46 +0000
Received: from MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485]) by MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485%5]) with mapi id 15.20.3700.014; Thu, 17 Dec 2020
 21:31:46 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 3/3] scsi: storvsc: Validate length of incoming packet in
 storvsc_on_channel_callback()
Thread-Topic: [PATCH 3/3] scsi: storvsc: Validate length of incoming packet in
 storvsc_on_channel_callback()
Thread-Index: AQHW1LPxKLsx3C4TL0e51vhHQI4gOKn7zkoQ
Date:   Thu, 17 Dec 2020 21:31:46 +0000
Message-ID: <MW4PR21MB1857FB51EBF0736728B8A432BFC49@MW4PR21MB1857.namprd21.prod.outlook.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
 <20201217203321.4539-4-parri.andrea@gmail.com>
In-Reply-To: <20201217203321.4539-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d13a911-6d15-4af9-bf30-7ef27bad02c9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-17T21:30:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:240f:4d5f:961f:391f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1825e19-3091-4ae2-55bb-08d8a2d327cf
x-ms-traffictypediagnostic: MW2PR2101MB1052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1052139221A67D7D18F60CEFBFC49@MW2PR2101MB1052.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66lnXAZRkZ8hTVIpcIdURabMAGwvvZh64PZW3WgpFZoVoOCf8G7tpuBtyjAkuTmvX2ZBNZDYXDGf2JTMBM/S/jZOWHyhEIP3HD94ZmYSahWeFGGhISAvU/CqPTpfYKiA9YMrP4oN090RvDSPVGt2l3iewga0WZ6otkG6z0tZx/MBNC6tjs/c2eMWX/coHHHwzG1vGQuZMs3QJdZ1hqFD7v9XbO4ojn2wQFV7RV630akyX3X3wOtUeXMoGvEZSPzxKsHyFN+Xz4L90Rmw4P8RNLcdfsy/XCfPjsjqlpyciOxoLwuvORLB1teyKkdKtfIB8W2QaqP2+Q0rjAh8aB2ChOy4hVh/DCE4Ra+bqUYKNt+1qDh5LKKTqrx+8QN6JUwK+x2h0mK7sjwEsdqyeQCWig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1857.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(8676002)(478600001)(55016002)(66476007)(66556008)(10290500003)(52536014)(66946007)(9686003)(33656002)(54906003)(5660300002)(66446008)(2906002)(7696005)(6506007)(110136005)(8936002)(4326008)(4744005)(316002)(82950400001)(82960400001)(71200400001)(76116006)(86362001)(186003)(8990500004)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eyzIgeztsqrLxldpqC4vn4wNSBIBOn5bcFdrFc6RrgEAucSEnSkMu5kbIYXJ?=
 =?us-ascii?Q?in8EFb6NOxHikHOOG/wi3zxohP6LCOYnaFn4nO2Zg5PYnKf0U/2MLiMK6ERD?=
 =?us-ascii?Q?51HXYKZWcgQOrzmYu+6O/bIqYJjfYipgxXbZigIXm2trZaXHL4SZC+hWrMg6?=
 =?us-ascii?Q?5xuJM8sKB1ApvHj+SXSPWPQ6c1BKZKfIm+pdLUgaZmxMlQUxWMfxg0VRl3q+?=
 =?us-ascii?Q?+ojPw9LIzyMTv+MJbamovsLH+dRLFfMjEp3zCteUNl+7IbLR8aJuxf62Uh9y?=
 =?us-ascii?Q?/Fz42Q5eA69lJNlvxhjfp/TFOV7FK5FRoEtMHsckCGt8bBJJqP3kKCwGgMeN?=
 =?us-ascii?Q?6SVgLVDulRiWXSR+AI16p/KKng8M4PhcXcQd7OpYWASw5PJI2keGPsSrL1qS?=
 =?us-ascii?Q?OHbH7rirN0vVciTW4PrB0HGJzy03E+ttjT5KoNPw8MFJex16WVk7EHW+UWhz?=
 =?us-ascii?Q?fbHJwokCCWl6VTGJIaPo6IY4MtlhHw7ZLiuoYnsgpoWuM7CQtlcPaLpOJJBa?=
 =?us-ascii?Q?/9D70GjuobGz/b84xaLPx4DuxiJRg8A/8ACFnX9Yo+Y+RRDL1QxCvHrd5JHl?=
 =?us-ascii?Q?698W3/1L2GOwiJwn/I1NwqH3/PMOnaezlKEM/cH+HCUmhN2FCPwrahfwOyK1?=
 =?us-ascii?Q?WC7NAWm6ygtC65xHAp+uNBIO1ZwEsv0Jtajm1bCw84ljX4o900iiwATsuSoQ?=
 =?us-ascii?Q?s8QSAPD/TyaaUmOvq+hKfIXNxOy7Pq3+rYNBBevBxsQ0z0GahIHqrzpRVkH4?=
 =?us-ascii?Q?BnDU49N7qMIY5zIwvzxHA2e106tbcWkV/nmdyThMx0FRti4dtx32IlRaIERk?=
 =?us-ascii?Q?X4jMDF/GMCv0yW3/jCiYXL0X2Gd4oDbqVKnJBj4doEH4D9k5kBo6P8eBBW+n?=
 =?us-ascii?Q?OdtI9Ld9iomcaYpx/or/mVI2Y6e37pLNUxKnGg6Qf0WE6+8+pCZI10oNZHgP?=
 =?us-ascii?Q?UsNfAjgSZB94lkSz5RFsxyjuNCNHEAZIDxJNRjhmOQ8Fb1MKF8oKGr5pVm6T?=
 =?us-ascii?Q?fBMf6uAgxrrbXUlatzEuuzx5RRCrjvhuj+eJUVFSjh/34iQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1857.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1825e19-3091-4ae2-55bb-08d8a2d327cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 21:31:46.2046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4GFt1M1rG7sBBEnutzlOjuCdXuBdTKGkGwj9X5zkrr7iRcVkUYOJ0blXgSRogwK4BFHu3FAK7uiIqXQJXVSLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1052
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Sent: Thursday, December 17, 2020 12:33 PM
>=20
> Check that the packet is of the expected size at least, don't copy data
> past the packet.
>=20
> Reported-by: Saruhan Karademir <skarade@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org

Reviewed-by: Dexuan Cui <decui@microsoft.com>

