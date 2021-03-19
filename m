Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2D342794
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 22:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCSVUy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 17:20:54 -0400
Received: from mail-dm6nam08on2093.outbound.protection.outlook.com ([40.107.102.93]:19329
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229912AbhCSVUw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 17:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvSkdeJByKoTDGpwPhfdhY0ofUbY+ItUmxrTlPypC31T8ZIJI9Hfxdw43YcDC2Pz/fP07oTAABhX3YI+po/uvmeBsmlwkUuZV83qYBWgWVvRP9CKBPV2pta5v/NNVEd2xztNU+tM4CZzPCULh5yylD35F1z6wRCOxPeG8EmBF64FUiNP7/JNKQ55iLfdYMRAes15wEMyvw4792gVXV1KR9cqWhILTXDfm+0IhsHVvSIrZySPz228WxfO8oVEurfiUffgrsZsq1I+mzWVQkwZLFy2Mp3jn4nIFccswwGW8YeeKTkJCbRsz6TmwYHcMGKTtCSp/lkrUNsrHAwhDVrkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/+O8EPaJV43lb8kRZ/ja17i0ecHkHhSR1hfkmVv6V4=;
 b=ldAZD0d6F9Cs9+l8u0lzrdM36tHoCIinru2elSl/XtG2Xw9GdHP/N/Mo3lPLDDVa+vgSlp7yx2g+v/eiFZibNilPLhWY9+1pWaZliTOO+c34mXrzlKRV0n18Ffw0S5gCNs0tpSNhXNx4cSdNfY7Fx5gckkS4KIRPYyNeHbVSMxf9USO0rkSmeB0xpnl8GblsQ03L+3DBeX9tG8nW2sam1BBZLEY7+y9caY810BoRyv1taTlM1pNN3zHuNVsqTvIkcOL00C1+6lXMzJlyBizqkbT5w18Cfm07KCmXNH14IOvJTGQEYr5EVkr7QUEpgyIDjUhsqGxO/BmuavRtxjOQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/+O8EPaJV43lb8kRZ/ja17i0ecHkHhSR1hfkmVv6V4=;
 b=dhZvhf1ncJO72X5tfTnT8m5loB6X/plkc1LlzihBKqMLob28zcupeKmCSaSToVSSui/UqfFlyd31SLNVlzbYGGKxBvMEz3jA5m3LjL5Hio3hsLcBQx9zQ/nHo40a3itKA3eOgdvI39WwflGO06EDfFdwDGOnoM8W4qcGehHPW7I=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1614.namprd21.prod.outlook.com
 (2603:10b6:805:54::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2; Fri, 19 Mar
 2021 21:20:50 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::9c4:80e2:3dca:bbeb%3]) with mapi id 15.20.3977.016; Fri, 19 Mar 2021
 21:20:50 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Matheus Castello <matheus@castello.eng.br>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v4] x86/Hyper-V: Support for free page reporting
Thread-Index: AdccMlTLMSKb9zjfQ5ekuWl72W2QRgAwfZZQAARAtUA=
Date:   Fri, 19 Mar 2021 21:20:49 +0000
Message-ID: <SN4PR2101MB088036B8892891C5408067BEC0689@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB088069A91BC5DB6B16C8950BC0699@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <MWHPR21MB1593BF61E959AC8F056CDFF5D7689@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB1593BF61E959AC8F056CDFF5D7689@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-19T19:21:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37bbcf07-6dff-414f-9af4-6f29abdf034d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:95e8:400:6cb0:9c5b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82a064c1-1b50-46a5-379b-08d8eb1cdeb6
x-ms-traffictypediagnostic: SN6PR2101MB1614:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB16143269B8622790784D876AC0689@SN6PR2101MB1614.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9feN+gsvS1vn3P9hUHiT4m3vMnksiPqGKTp6EFTVnfsUXxGL8AL1Ec+cQl1FVqHrS+Bm7HZrtJrFfi11J/M/4ldHcH7PXWLxbCAcHNJkQOM3YTPMhwy1l+F2cYvr8botdZeEX5EM1xZZgAvR2fakquKp9yW2IKRmNfUMg+Rw5GsSbj9tmIcVaWnYJ2nQuCVavpOnEG93aH1eylhzQsQpw9XqDhhQmgd852SRnTQLgzWIJVKYorIpd0OhwZzy6gcUAedJWMrCyU3RBELbjMmg2Whaz/hr+dTu1K+e6oGSOA6IEcL3+YSDXjynoGP86ynHNI5Ygo6UFiV8qd0RcvLScfsVj7VUCw+xaHGBF+IZkEeZ3dCD/5iCxPIrlc9DI2vEX4w2s4osck/C+9wTvvF7Jr+MV9Nsxl6qr9yVTuv/eHhE5LIlZEshKT4cjoSUMfjsAl7ydoY/Woij70kh9BvmswTYPw8QYCyJq1KStucHCDGLU8U5qVOaZ8pyDp32GifrZfABdTbFqqXBxQRoWlrbDpE2mhYdocU3Nn94gECzMeDbrFS2R/mvp6eKUw2TBQxdomckMyAJoEMdKLY6gUU5/toit9SiE7dfwZ9U2qJerV2foqP007dyvqrf551ubnirAx5znKVvEQ6pAVrFa460gIo8W9FcSAUDNixNiNcgItAnCIZdHsokkmNAM7tepxE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(478600001)(66446008)(86362001)(52536014)(66476007)(4326008)(110136005)(33656002)(64756008)(76116006)(82950400001)(66946007)(316002)(66556008)(71200400001)(8990500004)(10290500003)(7696005)(5660300002)(6506007)(2906002)(4744005)(8936002)(38100700001)(8676002)(9686003)(83380400001)(55016002)(186003)(54906003)(82960400001)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L8VUO6IlxGAl3S07XLasjX/YCu6bpxNN11GJrdRLDH66sws4zG59Klwyd3Ha?=
 =?us-ascii?Q?zhJtq6k+jiKGu1pVNGMKXtUWGti1RYTVbb7lR4TtK83qkJ1jCrIvomcN1qhL?=
 =?us-ascii?Q?sqjsNUTcDmdlXNqKVZieJW4DP3D96HWDNT+nBmuVdAoevEp2obPljZKOmeWA?=
 =?us-ascii?Q?srBz70SeM46uVQhEcTpSwnmyMD1pElyUVSjM5YVZIyXXXYZg/JDK+lI1fb8Q?=
 =?us-ascii?Q?H4AJNNSTcNxvIkY9hUahbFWomdTx2HDZzXy3KalwcjaC/hGopygjgWH9dWQP?=
 =?us-ascii?Q?HrMrMg4RtODjg5wGeqgW1m5emuR90a+FkYtppOjuPZ/4QLMvGiCDZA0WFv0N?=
 =?us-ascii?Q?PQV0y7Why+19HWgRT+LvPrS8bRbY9Ft6V9TmC/bpA7NB2YpkvxpWQK3H5RYb?=
 =?us-ascii?Q?bVX4kEuJRXW1aOTeQryGy4eDpexgiPfzs1zpKXIbgTTX3Jg84TNyeoT3V4Az?=
 =?us-ascii?Q?HCR3rnfQKJX8fXqAcpfDLxyE5fnx+DuS+mbX3p36bFMagx64pYx2868dbHuP?=
 =?us-ascii?Q?Y9wuq1ZuBbYibcv8NbMWAslVPOa0DqOJMkPgngfV5jJIJIKtCtymm5pVYDxl?=
 =?us-ascii?Q?yxw1lvZmKJ5zk7cnB0MWOgi6EVME5T/8KhOdRKBjdvR5uaOSXOFNSVnC3M9e?=
 =?us-ascii?Q?cxObnyPCFERq9ontqiGygFYPRGlNkCqIrkkpK6JMlMac9RHUceHsUGTGd2tG?=
 =?us-ascii?Q?w/bho9k/IEf2c7TFGkuz8zAHjBexC03pb1VElcnkV03eMeJtW8Y9JOfYvzLE?=
 =?us-ascii?Q?DEuoBCt3uLHw22/9whkOk85xv4YgqJ+rp8nrhAwyC1fxXs6AEff9MQxIrO67?=
 =?us-ascii?Q?GbT12sHorDs/UseRueWdypL4tJcI7ogV0ewqXIfyM5ZK7xnrM80Fvl2Qvw8W?=
 =?us-ascii?Q?q3NV8poQqPm1k2eoNWhBGCQVMJEFA/Yu3GbKWURWb7ifjh5FJv3ery/shyfE?=
 =?us-ascii?Q?ZrhnkW8zL92Sc7EV9i8ujuahN6xU+c+lkQ9coGuAz1JCj+2stlS7396Gg46Z?=
 =?us-ascii?Q?wyqbGUwj7U44OAPCTrKLGtdZeX8AG0l+m+dsZbwO0YpHhdSvn8F6wwVxcKIh?=
 =?us-ascii?Q?WwWj7Vi1xlhaQu9Rvvd2lxhoFyfW4VVsIEUGU8HDioXu6nVdFE5/ANr8Zy5z?=
 =?us-ascii?Q?/OoN32GXzQ1qSuM5PhUJIvWFsVKOWPaVuoeVevLwslmg6kPTlyk9Yx7wET/O?=
 =?us-ascii?Q?m3fgL52BjRSa9JauEcKrftomgni1BRPgB6T8UMTP+JJJMSlEZ2FjqRT984W2?=
 =?us-ascii?Q?nx/gPTfauImO+QGN17G6yNW4Tqvn4bKW6lDTyFoVzkwYt26JvcM0G0uchwoC?=
 =?us-ascii?Q?kWsb6t+IKuj2al+en1daDSQJDGdaRGAXcJLGJDpdjEbEVCo1X9BisdXTSQVg?=
 =?us-ascii?Q?Dz447PhUrcbUbFrFdhmMzdwTHgzQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a064c1-1b50-46a5-379b-08d8eb1cdeb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 21:20:49.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cu+xiAwQeu1714DY4VSjOdAa7IFblefxXjULo3waqVR4yk5GFJqWlRRQ2+o7EgFsbeGtDhtdxQ67i0jahVsa3/+8o5vzTfvR1A5y3l8MBoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1614
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> What's the strategy for this flag in the unlikely event that the hypercal=
l fails?
> It doesn't seem right to have hv_query_ext_cap() fail, but leave the
> static flag set to true.  Just move that line down to after the status ch=
eck
> has succeeded?

That call should not fail in any normal circumstances. The current idea was=
 to
avoid repeating the same call on persistent failure. But, since we don't ex=
pect
the query capability to be called in any kind of hot path, I am ok moving t=
his
down.

>=20
> Other than the above about the flag when the hypercall fails,
> everything else looks good.
Thanks for the review.
