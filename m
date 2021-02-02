Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49F430C96D
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Feb 2021 19:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbhBBSRw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Feb 2021 13:17:52 -0500
Received: from mail-mw2nam10on2127.outbound.protection.outlook.com ([40.107.94.127]:34368
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238319AbhBBSQL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Feb 2021 13:16:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrAqJ8yERDqM5U+/2lp1B0h/mhqZd9FOZ6xsJ/Ms8pTSYjILHmHQ+HKy6kS09crsA05M5+GWwF+IfcTegjqdJ/q9rIrmZTLRMxdiCZfyEwdfgWJ3yhOp27b8g0CHgi/lcng8jBTHbRdhjeKMKbwWdtLNlALtoB6uTOt64EsB4i2Uqpvdn/L6AjAF6MDBDUnjobvv8BAvwl0jQ8r9ClwVeBemk6OgPPt/g1l+X7pwPLCgNiFhrJoev2/JvxmHdl7qrIKR7S5htYjb9HrWX7lrJHx6deKCZSsyh3Y752b013W8m+x5iUyb2XZcT/WID8tKbubahFPtgIURRBs2/GGAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JErsqbaIFT9wVPKx23BjdpP02l4DuSsKdBHs+iOsLmg=;
 b=b0eBvnm5PZnXas3ntGNzBmeAMeB5KbA474Uf3ZKU3glVBuj3irP7kf5mNQDfm8ol/LR3tb91uys8jnvUQM8tTckUgJJKHjMRsId8+V1hb/HY8KAc+yjINbE5I5Sa1CmcyogOVjjXCL6BZKBQZkZLmDaHTCAhaap0DU+VDZlktQXI6Ybz4CE8gv7Q76FkcuXXDf9hGpcjo9FAaytPgsD1M4cdcL8t0QNDfZ6sQ9iIJ0x0fX8jz2J2ILJP6y9JsBsFF0giQKkp7F+L+l9DPs67KQ27QT44fGfIelRthM0SBxR5IBW2W/EtVI/BWguSIkIfBYYXxlszZfiGp9XVm1MBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JErsqbaIFT9wVPKx23BjdpP02l4DuSsKdBHs+iOsLmg=;
 b=YEYgGg+8JugyZWytozLYyt80vepF7EQc77NebcmjTk3+MGTf25C2Bx/IWxizMgQKMWdyx43XThoh+JFYDvxtC2ES5lX2yQ1FzWVjnLp28yUCZnewjq85QlO5MMVOI6eR3ZQKm8nDrhQ89h+7dyAfMYBDZz8Tpw5jOH0XBgGapkE=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0863.namprd21.prod.outlook.com (2603:10b6:300:77::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Tue, 2 Feb 2021 18:15:23 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Tue, 2 Feb 2021
 18:15:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v5 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Topic: [PATCH v5 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Index: AQHW7yP6HaVdmem27E2jxVVgXGHGnKo6+DxggAo8E4CAAAsYcA==
Date:   Tue, 2 Feb 2021 18:15:23 +0000
Message-ID: <MWHPR21MB1593248BE6E343117897FE82D7B59@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-16-wei.liu@kernel.org>
 <MWHPR21MB1593FFC6005966A3D9BEA3EFD7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210202173153.jkbvwck2vsjlbjbz@liuwe-devbox-debian-v2>
In-Reply-To: <20210202173153.jkbvwck2vsjlbjbz@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-02T18:15:21Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=78830b72-2475-4687-9056-08988f88c1c3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b8759b1-1e33-4be1-925d-08d8c7a68242
x-ms-traffictypediagnostic: MWHPR21MB0863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB086335EF584DAC8527053222D7B59@MWHPR21MB0863.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJURzqnSMWuXTCCmaoVY/ipfg7G+BoqQCSPdx7aoGdL/Iyheeh2mfUntFx/M7/AaQXYlJZSmyX2IU6U0Rz0yeSTlTiuz8Vf2/BYNXNmm9jSyQjM1rcJgmJQHDq1U9qx2dhTf8ysGXdpOqaBxAJp2dJNg6yHrv9vfiC9lFRuTA7y3sHR5Gt8Z7y6REuZgFMnkuvJ39hMJfRvbzHtpogWN2kq7u90gRNVQilOayqMHidTnWRPbqYyc1lDZTiSpTjazomNRBGPK0Me1Ao49YjuuZCqzghOK6ZG6I9+XRtAmPVArpBF9LN5JKfgLEdUmtrebm4VO7Rs0e9BMzze1cq/3HfURxbFGte5KmTHZuwsJAT8yz8fW+EADgOz5R1QGprpyHOt8vtG6ConbypcPjDJWD80iG/UZciB4Hi/fDdBOYna9TcEhhMWG68QJ33mBzp6wHg6MCMmLM5zekeiqDqQnARrmIhWhjvuyb1MdM+uukSsRLiKT5uW16VXbFrF30gD7YLhu3CFltQMlr3yRijohTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(86362001)(6916009)(10290500003)(6506007)(2906002)(186003)(26005)(8990500004)(71200400001)(7696005)(478600001)(4326008)(7416002)(82950400001)(8676002)(8936002)(33656002)(66476007)(5660300002)(76116006)(66946007)(55016002)(54906003)(64756008)(316002)(52536014)(82960400001)(66556008)(66446008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WJzOnMMEiLiCxnc9KU7tDWPtolKqYmDxUgjAEQXe9Fq4UkrqdUljhF+YcZJY?=
 =?us-ascii?Q?D0I9fS6mNvKWx5C8FEkEavszCSeXpCoj8rvlFLJlb51mKb3/SWGsBc4OvUxJ?=
 =?us-ascii?Q?ZSph9Ejprna6CE/BwCweSD2hRaXO6PBLHPsb8G8Ige04rN8TSyeSomzv8av3?=
 =?us-ascii?Q?Vw6mTDDWAupOhXpqKZHGdw54dV/OVDUjMnIRx8ClSvXvX3wCzYd7/6l1UkRm?=
 =?us-ascii?Q?QSok+oX95amR35qK8unFdHxgm3OfcArXk9eRrKdWfAVbwiPOWiJYfEx8zvWj?=
 =?us-ascii?Q?/7DIjnW7Zms3RT4OMWaybQEc/7cBGt6ea5qMsToOrUO4Cj9bmo/T0y5M7zbG?=
 =?us-ascii?Q?9MS8RszXzuggWgHKooAwzDCd7JQwLcr2DFgxI9ZOyLtKUViDWAc59VISpd97?=
 =?us-ascii?Q?OP5WR56/D2HlOVgFycrnWG/roOR0b3QoK2aWMwZNDnkhWqOmZ5GzQBVD0X80?=
 =?us-ascii?Q?Ao/z1sovRXeij4icOStkxa8qvi/ZouNT3DGNfDdgsvmXBAdQOpbiTxLfdPNl?=
 =?us-ascii?Q?4OVG0R81U47TRZZUSuYtT8q3x/xlARlBVHoWEQSFnfCeoqsuxAbLjbcf7hc6?=
 =?us-ascii?Q?zGsP+f4GMO7DDiJ/GFsrkafVOQnEa1T9fukK4a3ewBuP4xgCHrduU4+MD3bP?=
 =?us-ascii?Q?8FJMcbOFztbGHCXy4EJ1Un/5nhFXAMguWMhpTXKZXotFjZB1pKJDP7rL638k?=
 =?us-ascii?Q?cAhJEezJuZA11a7t8bysf1X/eLcsoIpBVlqKGaTvViUKvjVIdpAiTx6NLl6O?=
 =?us-ascii?Q?HVW5Ck7T/y+zxtrotTr+0JXrtkfgsJ95mwM1thhoxCndDZoKGOz23mJZFA8z?=
 =?us-ascii?Q?oznIT14tiaf3NpR0eMwGzoqlmJGagjkfBcM4lmfkD0hzQTSeQYA/uFJKpG19?=
 =?us-ascii?Q?bw4h0d5sY7wLNU4JsL8TYNYaob+uQDV327wWRaj4UIFmNfeA6QRzXllIEv7N?=
 =?us-ascii?Q?XQzHalEeQ/xrrnNwBKy9agJPdnIuSYATgDN412VIvC2BxiGVeXMFu8aG0lO7?=
 =?us-ascii?Q?l6vsGpHCWf5g8ViYich2Zz979UFm96wDo/0F9HoUqWOI/F1kgTEzU6DV9h60?=
 =?us-ascii?Q?wSIZHhGrW1n7oJC+mFSEv6j0k92Vp6biYJW2/iUzL+wPA23EInf1dqmdMjkp?=
 =?us-ascii?Q?v2lvTbbOxQReNBHSndnqIvneNVfdpIq47WmPr/BQgEkao8cHxyryijiQLMHJ?=
 =?us-ascii?Q?TjN+ceCn55nFzpj4TZ8v6EkhyKJIkeA+Ly7hfcFVm3O8RN37X08TBZcUJAWl?=
 =?us-ascii?Q?PhUh6EKaCwZQiAua/zCvjJ8X+h91pAyxrcPGdhu8J2VZqRfprxS/ObkQEV4D?=
 =?us-ascii?Q?cSwzsauHH5X0Kgg2rCjte7P0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8759b1-1e33-4be1-925d-08d8c7a68242
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 18:15:23.5935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTYa4kuDgldT6+0x6Y4jrsgiinqvDb67+J6PdzuQyFaY4U9WCqSclC2W+a9MzrZQu4AU/nKrCMibKtBfawFxwrogRQ8cc9bpzX8O7zDg+SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0863
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, February 2, 2021 9:32 AM
>=20
> On Wed, Jan 27, 2021 at 05:47:04AM +0000, Michael Kelley wrote:
> > From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:=
01 AM
> > >
> > > When Linux runs as the root partition on Microsoft Hypervisor, its
> > > interrupts are remapped.  Linux will need to explicitly map and unmap
> > > interrupts for hardware.
> > >
> > > Implement an MSI domain to issue the correct hypercalls. And initiali=
ze
> > > this irqdomain as the default MSI irq domain.
> > >
> > > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > ---
> > > v4: Fix compilation issue when CONFIG_PCI_MSI is not set.
> > > v3: build irqdomain.o for 32bit as well.
> >
> > I'm not clear on the intent for 32-bit builds.  Given that hv_proc.c is=
 built
> > only for 64-bit, I'm assuming running Linux in the root partition
> > is only functional for 64-bit builds.  So is the goal simply that 32-bi=
t
> > builds will compile correctly?  Seems like maybe there should be
> > a CONFIG option for running Linux in the root partition, and that
> > option would force 64-bit.
>=20
> To ensure 32 bit kernel builds and 32 bit guests still work.
>=20
> The config option ROOT_API is to be introduced by Nuno's /dev/mshv
> series. We can use that option to gate some objects when that's
> available.
>=20

But just so I'm 100% clear, is there intent to run 32-bit Linux in the root
partition?  I'm assuming not.

Michael
