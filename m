Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F561A5EC
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Nov 2022 00:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiKDXia (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Nov 2022 19:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiKDXi3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Nov 2022 19:38:29 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021018.outbound.protection.outlook.com [52.101.52.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B514D2F;
        Fri,  4 Nov 2022 16:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRuVY29KyCi986zFIjG5jVsxofzfVOQoyRg2NH6Dm5YdG3a873YAdzIloCPxtroZAsRuYdaPROYL9S7mFBTK5ThJlcPW8ccuxO6XKovaZFrIkGlBEZiIzNPW7nrkotcJ2uHhXOWEynT01zY+Aw1HKu8gj5SDLudvnpDzFNsYuFbFnMgseEoFWG9DAJk058vwNKe19keHkqU8opKuBjMfwISL4TK8+x1e0e2cyFlTJmxySMoMw/fPRuFtKnzQBXHoYz5cu8neUFqmIL0AhpeRQC2nXqvxR2Zy9U2vZuHvmE0lWnH3DL3nOnJl5gEO6zX5PLIfb050A8SY/Y1FCAnlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVUFkwVex+rpzTgxMOMGIBoheY1EU7tdBESeGlawLiw=;
 b=Bbg4ImVbJ0jRQt9o6IUV3O8uM0HlO7NQgpyC7sKfLoekLXiHX5834hNa/A0Mgnj3ZaBDJPEpVwmXja3XnfoRveGU+Z9Rhr+SJQpAfT3xG668YLvENBZwJcCuLVwaK28WHxTlxMYmQLZ8CGB+yjzs5IdMdKQWUOvD8eNpjYoIPqYRYdkEplZREQxL+jL78iYUTiROu1xh+21zeMIPB32HNKpWqvdRFc742L9/znd0T9D3GJFvntmafX+vnqCXMVHZsevA1yAp4yHhB+5UnMJ+YnjcWvyi+xd7ibPLj1COVVjITFN2R4ABALyBQipWXV9ST66xHL9LQ3JOO+UGzLTYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVUFkwVex+rpzTgxMOMGIBoheY1EU7tdBESeGlawLiw=;
 b=Y9I3+CDowV19XIC/D2MiUhLbKJ7gJsogGmEM05QyAVfYMZZedvdWZ816fdKaGwqW/KvZp4s2yw4H/BnzYZo5F6vgM20/eF8uPpAQWZTGGaCBg0xQ+NTFm3rKysBVe5Y0i9R4ekzGb1uAy3JM+4mEVf95J4+z50td0EaisErVGU0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1917.namprd21.prod.outlook.com (2603:10b6:a03:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.9; Fri, 4 Nov
 2022 23:38:24 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Fri, 4 Nov 2022
 23:38:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "quic_carlv@quicinc.com" <quic_carlv@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Topic: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Index: AQHY8J0alQKzFek9kkuOCBwYhpuQEq4vaxEQ
Date:   Fri, 4 Nov 2022 23:38:24 +0000
Message-ID: <BYAPR21MB1688378A6403AC46FDF41B7CD73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221104222953.11356-1-decui@microsoft.com>
In-Reply-To: <20221104222953.11356-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=35228208-0f21-4b36-b68f-17ffd3e36c8d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-04T23:35:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1917:EE_
x-ms-office365-filtering-correlation-id: 4b8dba14-ce40-4273-c115-08dabebdaa9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xPYPn4bBKj3C0VCOIgZ7O/hBatDWozcEntLshRmWzQ2R1akTnGQjaxarflGqU+IPjQoaPRrnL4u6kt8ZnVoJ/YSzfJ5LPkHJjtUUZp39rvx+j8B5KwJpjfyipsO8DdO9vlOYkdY5814oVLOtN62z3Kz8bVM1Bgn7z22vbtsVupgUtc7auEkAAcWRL2NxcApV0qHkxBzzDUL1s6A2azRcfN1wxwUh4NFUXIQNOO06VFBPDurNLQp8yLzOAXzwhsMLi7kr6+vSizfIFquEy6Dc/bTRcsdBpIlOZ8GqSXVbtCYmiIFXMPSRmU0oGqIVC/2P3yh5wor/4i56RRus3l9mTECSzLnrrV9IKgwqVf1FnAtBtORiFtoO9k/alKCmiHgNIUr3Wt0LD0doqcIZLc30hTfsPUMfd+xKoJPwPwfBQw2Fj/87J7haJvfjBt7U9flYD8m/miiG8ByX1vffN/Fn7ekZQEqRCYzwqNeVynP8A/0Exu8DmmdD7hRv+uWmTRQIKJ0gvTpSqtluNzkJiXiaYrd5dTr0k9OcroSYtclotCqWz1cc8meaVg9pUF+OpkxENcrdkcpjRClwXlHfqhCaz6IogU6VqLD9a7C7XNIMoEZpDEVYv59lAenqhE6bmmySYInnp3ce8HWescMjwLY1tQyYP2PjNY0NG/vKr4f6oGA1PP0fDdyoP5p0Du/Woef1RgmQ6h+Xw2+n7e1b6FL9z1D3ZuRzi6VNFxnGupZpQXxAY48tcsUDNyrMW9rU4YRJl3beBWPbfOB1F0NrTqYSPSHPW+y7hTPKKG8HwIoJR0Y94v3H4lN1TB1mA9pfTIw6ilujq1D/2pvTmeLi7U7o3oMCiEvuOsLIIgftWPKARUdcW0ZzESzGyje/NE0zQnJT924yoekrv9cFwVUlOolFIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(110136005)(8990500004)(86362001)(921005)(38070700005)(33656002)(30864003)(55016003)(7696005)(76116006)(66946007)(8676002)(41300700001)(66556008)(64756008)(10290500003)(71200400001)(186003)(66476007)(52536014)(5660300002)(7416002)(966005)(478600001)(26005)(9686003)(6506007)(6636002)(316002)(82950400001)(82960400001)(38100700002)(66446008)(122000001)(8936002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AwX+HX+ZKd+bVbjgqzvmduEh6Q9woFNxhVsSUPtqWq3vacu9laZw0zNH7xcM?=
 =?us-ascii?Q?1gJihkNqna41CKZ+ioGJFIQKxAt6Acp0yD14bv0qoOxZdl7XzsFwziMsvf/A?=
 =?us-ascii?Q?NGTJS/80LMkwPSOrY6PlV+xFWyldeoDgDZTyCPJ77kkZZckTUPr8SyiQyOF2?=
 =?us-ascii?Q?xxlFSUT1vx0GAt+YQ+d94b3r4q67fV1Ng1HNDo2dVKMkedEflDcVPmoAVC5A?=
 =?us-ascii?Q?agTcMGemL0FpFxenUGUxib4tAns2ErtzkUXB7WQvzzpLyzZHx9aV+4rMLl1F?=
 =?us-ascii?Q?CcSZmvDn/QaNsHb66xp2lMPapRqZm+BpVsw5rMOBh7vlzYcE1IXRqSRk50+R?=
 =?us-ascii?Q?1q/frdlY1T+pfyU3lcM44Vjzy6I09SyGuUqy5SvVXyBzJ4o7FtHVfJ5vSPhB?=
 =?us-ascii?Q?eG4EUiFgmt1Zc+2jB39bzT2FBiGPOyvXHHrFmStdxZpW32TB2VdHMdvMDLKs?=
 =?us-ascii?Q?aI7FSTTwZuzIdsZKSPB7jVa0uLMF+pJ0oAbIpb83k2wL0E96+TvwwomnPVc8?=
 =?us-ascii?Q?uV7nQ5AU8MrWSv8AbuseGcwSu+Nuytq4qnnkSBZob+NlcYasHwVQh3W3fByt?=
 =?us-ascii?Q?LjBr10tCuFCT8qH+jg38slBRuOlKy0qzSXerNO4k947i/ULj6vpRIObzvRoD?=
 =?us-ascii?Q?tqNnVeb6Tb8diTe7zq0/LDclSPhMrReV1ebDkVUBxqjhRzSn+3BFCxrHBN3n?=
 =?us-ascii?Q?uWUSPHct8tg+ui90I1CWbvTYKxwJmMTkXHMgIx2xXlIsF2Y2/HlWZlxrgO4y?=
 =?us-ascii?Q?gLUIbfatngN4x+73wLb7gJtcIzwJADQMYfO3JFSzEtdKdGwhTgxdj7KQjH6W?=
 =?us-ascii?Q?hq/85LJ6pJlXOUlWXgw1owZCu+HxVN7VuZ95qREmfZRbm6ef54CIJy6CJwAN?=
 =?us-ascii?Q?3kwdcbnanB5MxPNd/NJND4a3d3i/qUKuB7mmS6LmyRvYcHQp18i66YWi4LWN?=
 =?us-ascii?Q?vZMCcZwt797XUIfjAL42gMod6iDYq9DtTyGi1aYjh2e/DD+rcUyLjEdWpqq5?=
 =?us-ascii?Q?1s3hVkChcH6nfR5ipgCPZQAhPrPzC/BYlbje2oLiUvJVJW5VVKr4J2/1tXH3?=
 =?us-ascii?Q?/R+DLOITiXl9aCwqT0AvOu4s2kGY+8nlxmh9jDPmL8DdCR0hv7ZieLkN8xah?=
 =?us-ascii?Q?v2L0ZYzyF5wU0oPJHSjwTOHnnWrUdqnzwge3Rm1Chq+7Yp7K7oM8flU3TSKd?=
 =?us-ascii?Q?Tltm5tllmuMzmF/z3ao1cJ9YMQ0v0Eib4CLgTDue2mkHgKxU1FEV4htVnfbC?=
 =?us-ascii?Q?InmvkdfMczExaLzAWOXLD8yq22Wl/GzdsFZIPfckLyrZPO3BiU9hVA2mgE3p?=
 =?us-ascii?Q?5R2jNPMMBlCGtNVYhiX6vrw78XxuJC+dEP+PHqrn/2NQxl/DhwbxlRINia8u?=
 =?us-ascii?Q?jFmeL/gRijpcyDzs6yQjW/ykkJZOVQlASGgw+V7p7RlGm6x+/hpP2J51OiGg?=
 =?us-ascii?Q?QR0dLVlHsQDUjuD4F36QVv4zfalbRYrUjwaGK1RFvgSL/P52vXKS3PeGwFTi?=
 =?us-ascii?Q?I9LNaeRxlG9IAnnAO5wveWmBMAKcKNisKCNh4hiFhRfsF+fYXbyeUtwWRKr0?=
 =?us-ascii?Q?/vEeqfSbfrmZyGjGY2vFPChBWMmk4DCT4YeSnlFfhytsJhnHjiHZGkGuUJGT?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8dba14-ce40-4273-c115-08dabebdaa9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 23:38:24.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jitRpLhrzTUKAWHPH72PIcJs17Nlk0Vm4jHLSKnKh7AmBpbQOEkvugz+qaYJU5uAyFHnYWTiULsx1aI7c+Tavg3FYJXyzNS4n9xLDXVxFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, November 4, 2022 3:30 =
PM
>=20
> Jeffrey added Multi-MSI support to the pci-hyperv driver by the 4 patches=
:
> 08e61e861a0e ("PCI: hv: Fix multi-MSI to allow more than one MSI vector")
> 455880dfe292 ("PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI")
> b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_msi_msg=
()")
> a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
>=20
> It turns out that the third patch (b4b77778ecc5) causes a performance
> regression because all the interrupts now happen on 1 physical CPU (or tw=
o
> pCPUs, if one pCPU doesn't have enough vectors). When a guest has many PC=
I
> devices, it may suffer from soft lockups if the workload is heavy, e.g.,
> see https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsof=
t.com/
>=20
> Commit b4b77778ecc5 itself is good. The real issue is that the hypercall =
in
> hv_irq_unmask() -> hv_arch_irq_unmask() ->
> hv_do_hypercall(HVCALL_RETARGET_INTERRUPT...) only changes the target
> virtual CPU rather than physical CPU; with b4b77778ecc5, the pCPU is
> determined only once in hv_compose_msi_msg() where only vCPU0 is specifie=
d;
> consequently the hypervisor only uses 1 target pCPU for all the interrupt=
s.
>=20
> Note: before b4b77778ecc5, the pCPU is determined twice, and when the pCP=
U
> is determinted the second time, the vCPU in the effective affinity mask i=
s
> used (i.e., it isn't always vCPU0), so the hypervisor chooses different
> pCPU for each interrupt.
>=20
> The hypercall will be fixed in future to update the pCPU as well, but
> that will take quite a while, so let's restore the old behavior in
> hv_compose_msi_msg(), i.e., don't reuse the existing IRTE allocation for
> single-MSI and MSI-X; for multi-MSI, we choose the vCPU in a round-robin
> manner for each PCI device, so the interrupts of different devices can
> happen on different pCPUs, though the interrupts of each device happen on
> some single pCPU.
>=20
> The hypercall fix may not be backported to all old versions of Hyper-V, s=
o
> we want to have this guest side change for ever (or at least till we're s=
ure
> the old affected versions of Hyper-V are no longer supported).
>=20
> Fixes: b4b77778ecc5 ("PCI: hv: Reuse existing IRTE allocation in compose_=
msi_msg()")
> Co-developed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Co-developed-by: Carl Vanderlip <quic_carlv@quicinc.com>
> Signed-off-by: Carl Vanderlip <quic_carlv@quicinc.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> ---
>=20
> v1 is here:
>=20
> https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui@microsoft.co=
m/
>=20
> Changes in v2:
>   round-robin the vCPU for multi-MSI.
>   The commit message is re-worked.
>   Added Jeff and Carl's Co-developed-by and Signed-off-by.
>=20
> Changes in v3:
>   Michael Kelley kindly helped to make a great comment, and I added the
>   comment before hv_compose_msi_req_get_cpu(). Thank you, Michael!
>=20
>   Rebased to Hyper-V tree's "hyperv-fixes" branch:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=
=3Dhyperv-fixes
>=20
>   Bjorn, Lorenzo, it would be great to have your Ack. The patch needs to =
go
>   through the Hyper-V tree because it's rebased to another hv_pci patch (=
which
>   only exists in the Hyper-V tree for now):
>       e70af8d040d2 ("PCI: hv: Fix the definition of vector in hv_compose_=
msi_msg()")
>=20
>   BTW, Michael has some other hv_pci patches, which would also need go th=
rough
>       the Hyper-V tree:
>=20
> https://lwn.net/ml/linux-kernel/1666288635-72591-1-git-send-email-mikelle=
y%40microsoft.com/
>=20
>=20
>  drivers/pci/controller/pci-hyperv.c | 90 ++++++++++++++++++++++++-----
>  1 file changed, 75 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index ba64284eaf9f..fa5a1ba35a82 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1613,7 +1613,7 @@ static void hv_pci_compose_compl(void *context, str=
uct
> pci_response *resp,
>  }
>=20
>  static u32 hv_compose_msi_req_v1(
> -	struct pci_create_interrupt *int_pkt, const struct cpumask *affinity,
> +	struct pci_create_interrupt *int_pkt,
>  	u32 slot, u8 vector, u16 vector_count)
>  {
>  	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE;
> @@ -1631,6 +1631,35 @@ static u32 hv_compose_msi_req_v1(
>  	return sizeof(*int_pkt);
>  }
>=20
> +/*
> + * The vCPU selected by hv_compose_multi_msi_req_get_cpu() and
> + * hv_compose_msi_req_get_cpu() is a "dummy" vCPU because the final vCPU=
 to be
> + * interrupted is specified later in hv_irq_unmask() and communicated to=
 Hyper-V
> + * via the HVCALL_RETARGET_INTERRUPT hypercall. But the choice of dummy =
vCPU is
> + * not irrelevant because Hyper-V chooses the physical CPU to handle the
> + * interrupts based on the vCPU specified in message sent to the vPCI VS=
P in
> + * hv_compose_msi_msg(). Hyper-V's choice of pCPU is not visible to the =
guest,
> + * but assigning too many vPCI device interrupts to the same pCPU can ca=
use a
> + * performance bottleneck. So we spread out the dummy vCPUs to influence=
 Hyper-
> V
> + * to spread out the pCPUs that it selects.
> + *
> + * For the single-MSI and MSI-X cases, it's OK for hv_compose_msi_req_ge=
t_cpu()
> + * to always return the same dummy vCPU, because a second call to
> + * hv_compose_msi_msg() contains the "real" vCPU, causing Hyper-V to cho=
ose a
> + * new pCPU for the interrupt. But for the multi-MSI case, the second ca=
ll to
> + * hv_compose_msi_msg() exits without sending a message to the vPCI VSP,=
 so the
> + * original dummy vCPU is used. This dummy vCPU must be round-robin'ed s=
o that
> + * the pCPUs are spread out. All interrupts for a multi-MSI device end u=
p using
> + * the same pCPU, even though the vCPUs will be spread out by later call=
s
> + * to hv_irq_unmask(), but that is the best we can do now.
> + *
> + * With current Hyper-V, the HVCALL_RETARGET_INTERRUPT hypercall does *n=
ot*
> + * cause Hyper-V to reselect the pCPU based on the specified vCPU. Such =
an
> + * enhancement is planned for a future version. With that enhancement, t=
he
> + * dummy vCPU selection won't matter, and interrupts for the same multi-=
MSI
> + * device will be spread across multiple pCPUs.
> + */
> +
>  /*
>   * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
>   * by subsequent retarget in hv_irq_unmask().
> @@ -1640,18 +1669,39 @@ static int hv_compose_msi_req_get_cpu(const struc=
t
> cpumask *affinity)
>  	return cpumask_first_and(affinity, cpu_online_mask);
>  }
>=20
> -static u32 hv_compose_msi_req_v2(
> -	struct pci_create_interrupt2 *int_pkt, const struct cpumask *affinity,
> -	u32 slot, u8 vector, u16 vector_count)
> +/*
> + * Make sure the dummy vCPU values for multi-MSI don't all point to vCPU=
0.
> + */
> +static int hv_compose_multi_msi_req_get_cpu(void)
>  {
> +	static DEFINE_SPINLOCK(multi_msi_cpu_lock);
> +
> +	/* -1 means starting with CPU 0 */
> +	static int cpu_next =3D -1;
> +
> +	unsigned long flags;
>  	int cpu;
>=20
> +	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
> +
> +	cpu_next =3D cpumask_next_wrap(cpu_next, cpu_online_mask, nr_cpu_ids,
> +				     false);
> +	cpu =3D cpu_next;
> +
> +	spin_unlock_irqrestore(&multi_msi_cpu_lock, flags);
> +
> +	return cpu;
> +}
> +
> +static u32 hv_compose_msi_req_v2(
> +	struct pci_create_interrupt2 *int_pkt, int cpu,
> +	u32 slot, u8 vector, u16 vector_count)
> +{
>  	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE2;
>  	int_pkt->wslot.slot =3D slot;
>  	int_pkt->int_desc.vector =3D vector;
>  	int_pkt->int_desc.vector_count =3D vector_count;
>  	int_pkt->int_desc.delivery_mode =3D DELIVERY_MODE;
> -	cpu =3D hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =3D
>  		hv_cpu_number_to_vp_number(cpu);
>  	int_pkt->int_desc.processor_count =3D 1;
> @@ -1660,18 +1710,15 @@ static u32 hv_compose_msi_req_v2(
>  }
>=20
>  static u32 hv_compose_msi_req_v3(
> -	struct pci_create_interrupt3 *int_pkt, const struct cpumask *affinity,
> +	struct pci_create_interrupt3 *int_pkt, int cpu,
>  	u32 slot, u32 vector, u16 vector_count)
>  {
> -	int cpu;
> -
>  	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE3;
>  	int_pkt->wslot.slot =3D slot;
>  	int_pkt->int_desc.vector =3D vector;
>  	int_pkt->int_desc.reserved =3D 0;
>  	int_pkt->int_desc.vector_count =3D vector_count;
>  	int_pkt->int_desc.delivery_mode =3D DELIVERY_MODE;
> -	cpu =3D hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =3D
>  		hv_cpu_number_to_vp_number(cpu);
>  	int_pkt->int_desc.processor_count =3D 1;
> @@ -1715,12 +1762,18 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata,
> struct msi_msg *msg)
>  			struct pci_create_interrupt3 v3;
>  		} int_pkts;
>  	} __packed ctxt;
> +	bool multi_msi;
>  	u64 trans_id;
>  	u32 size;
>  	int ret;
> +	int cpu;
> +
> +	msi_desc  =3D irq_data_get_msi_desc(data);
> +	multi_msi =3D !msi_desc->pci.msi_attrib.is_msix &&
> +		    msi_desc->nvec_used > 1;
>=20
>  	/* Reuse the previous allocation */
> -	if (data->chip_data) {
> +	if (data->chip_data && multi_msi) {
>  		int_desc =3D data->chip_data;
>  		msg->address_hi =3D int_desc->address >> 32;
>  		msg->address_lo =3D int_desc->address & 0xffffffff;
> @@ -1728,7 +1781,6 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  		return;
>  	}
>=20
> -	msi_desc  =3D irq_data_get_msi_desc(data);
>  	pdev =3D msi_desc_to_pci_dev(msi_desc);
>  	dest =3D irq_data_get_effective_affinity_mask(data);
>  	pbus =3D pdev->bus;
> @@ -1738,11 +1790,18 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata,
> struct msi_msg *msg)
>  	if (!hpdev)
>  		goto return_null_message;
>=20
> +	/* Free any previous message that might have already been composed. */
> +	if (data->chip_data && !multi_msi) {
> +		int_desc =3D data->chip_data;
> +		data->chip_data =3D NULL;
> +		hv_int_desc_free(hpdev, int_desc);
> +	}
> +
>  	int_desc =3D kzalloc(sizeof(*int_desc), GFP_ATOMIC);
>  	if (!int_desc)
>  		goto drop_reference;
>=20
> -	if (!msi_desc->pci.msi_attrib.is_msix && msi_desc->nvec_used > 1) {
> +	if (multi_msi) {
>  		/*
>  		 * If this is not the first MSI of Multi MSI, we already have
>  		 * a mapping.  Can exit early.
> @@ -1767,9 +1826,11 @@ static void hv_compose_msi_msg(struct irq_data *da=
ta,
> struct msi_msg *msg)
>  		 */
>  		vector =3D 32;
>  		vector_count =3D msi_desc->nvec_used;
> +		cpu =3D hv_compose_multi_msi_req_get_cpu();
>  	} else {
>  		vector =3D hv_msi_get_int_vector(data);
>  		vector_count =3D 1;
> +		cpu =3D hv_compose_msi_req_get_cpu(dest);
>  	}
>=20
>  	/*
> @@ -1785,7 +1846,6 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  	switch (hbus->protocol_version) {
>  	case PCI_PROTOCOL_VERSION_1_1:
>  		size =3D hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
> -					dest,
>  					hpdev->desc.win_slot.slot,
>  					(u8)vector,
>  					vector_count);
> @@ -1794,7 +1854,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  	case PCI_PROTOCOL_VERSION_1_2:
>  	case PCI_PROTOCOL_VERSION_1_3:
>  		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
> -					dest,
> +					cpu,
>  					hpdev->desc.win_slot.slot,
>  					(u8)vector,
>  					vector_count);
> @@ -1802,7 +1862,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>=20
>  	case PCI_PROTOCOL_VERSION_1_4:
>  		size =3D hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
> -					dest,
> +					cpu,
>  					hpdev->desc.win_slot.slot,
>  					vector,
>  					vector_count);
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
