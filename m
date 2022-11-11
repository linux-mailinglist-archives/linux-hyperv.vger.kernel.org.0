Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF268625FE0
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Nov 2022 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKKQzb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 11:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKQz3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 11:55:29 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022026.outbound.protection.outlook.com [52.101.53.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46E17406;
        Fri, 11 Nov 2022 08:55:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdE4s9QQfN58Niebzcj3jpODZFBNVvUFgZudlPBjGjqt5k31d8RxQDG0DB9EOVLKvjf92TFi6un7wKanPzfmDL4JXtGK+8DdZ2TBfsXV4W0dxtIorgSNn4nlDG3v9NzNzQwm/LqbERBwV2okappez+4AUsEWf9BaWaU6sHVDUnqmEEBwD992DZ4SLVaw0W8U/9SI33MlaJfXzTetoFbQzS1FxPZADmefZG39edufnSqPTgskYM+jWvag13UJCvJLbUNSbzQoMr5CfWbMf30sSkHEengkAYwhMUVwW2NKlGL27sE2cJDjAtSNLTY+b86jLGeX99J5hAJlZsHihFYBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njfqHttk9pjKKUJbQ0Z2fnLftNx30e5cBTY2yX3NcQA=;
 b=cHM504BSlnJDjmKay6wsR8HU2OYzC3Nkcso8pYBlmrHrtK7cPJQIi12SKImP4CjVg5bDWcm9RIKb1SFMvFmagA5Bbp4ohTA4Mdn9kzhToxl6LnUr1gbT7+7CUR7SGfueRSX/gdUW/y7Jzr6UHrATkm8/rOoU3aSpthzAidDyr5BzxKg1YEHmmoZpRDVaUQQevxG8aNlDH1vRiVHsLPMWOVB4M7q7NLkcZoEI6F4F1v5jBYO7cqGpTAM225ToR7w9vEICsDiBVohTQrNIHAH3NBo0G3svptEZR5TmSX3ZKbMV1HC9/ewr4a9xVZA2Lft6AiJYu7CVwNHGBh1NnEgf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njfqHttk9pjKKUJbQ0Z2fnLftNx30e5cBTY2yX3NcQA=;
 b=bra9d7lexK/Xiqjet12mimEILVW6j42p6YpA8Q+En6O2oJCVRNTztGCdi5SGzij1J2YaJECJCdWD1llbm3tVH+KDSsLOILCjRN3ffRMnMZ2r/YR8QgFrHFEfyGhcVMHlZXrdUMkVSt1tkPOyJLCvFraMX26csU3tg9r0QDGx/wg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by LV2PR21MB3110.namprd21.prod.outlook.com (2603:10b6:408:179::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2; Fri, 11 Nov
 2022 16:55:22 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%7]) with mapi id 15.20.5813.015; Fri, 11 Nov 2022
 16:55:22 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Thread-Topic: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Thread-Index: AQHY9G6MTvL64VjEeUSlJ0XIa/5zY6457YUAgAAElfA=
Date:   Fri, 11 Nov 2022 16:55:22 +0000
Message-ID: <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
In-Reply-To: <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1bacf23e-a9f8-475d-ad63-d3ca2bb3d22d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-11T16:48:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|LV2PR21MB3110:EE_
x-ms-office365-filtering-correlation-id: e7c261da-499a-4a54-9c6a-08dac40585dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pgXg1eUn8a0juaQHiB7Kd2HGHlrqMo6cH92Ibq6r05BnbFw5p6GGtP+Je9Ijr76qfmBvBV578EFVezetFlb34XHq1iRr4v4hYQhwSXePpjsvY0o/6x299MCgba05b+9UD5PIkZMLZA+8Wn5w7HhPE6mKV8pvUNEn491q7N863JAgHW2ZYIwD2iL3d3h9YyJ+A85GNTfsAet0xCAmnFImtj2MRZZ0Ay1GMC9cGZZDX6pyVxhPXsr9T0aFjH2busQ2Kk3J22cUDRyZy9n6kwAxF3bikMxGV77uBlflTH1Y+rG3wy7tdujR8eY/sdtere+6Umtesk+9gxNX979FxYQfSjuls547ZlrsXzHQSlRCAwo98YqDdqXLVFZJ955yzNymHK9Se3QpYZ3Wg1V9E5v8HTixSisOHt5DGl/HQENO1NLD6jIrESIlPUm2I5o+V4FP4Bd3FM70RCFdH51z+VYp0kbIBRLdGut9IydywbEu40n7noJ975tkoseHrsr+5sXR0LRKRXESVIi7m7pJ8hIEh4Zh3hSQaPXLrTk1F6cfJGqknwThD9Xp3tlS2k0Mlkijrkz6XyopBzqetz5JTprz27AWZLnz3vwPos801b673oDjcPXUj8eB8IQ1PK46HF6unhkTgMvqT2VfoJ27b/sFCipWKN37QMrBR8oTUt/kpIc0brfWvkYCuqvxJ+o3EQE/aw27UXRRCQUe10CqEqsJOJDxhAYt89RGsqiFXbirgPvx4/0OwbPaccubI+CAW7kLQOoWVylF1TwsuQVcFLJ5JQrSQFS/RF8EZXHCOFtexJaD56qPZvqLdxpWs8Vyhrsy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(6506007)(7696005)(26005)(83380400001)(316002)(8936002)(52536014)(33656002)(9686003)(5660300002)(4326008)(186003)(2906002)(64756008)(8990500004)(41300700001)(66946007)(10290500003)(55016003)(76116006)(66476007)(66556008)(8676002)(66446008)(122000001)(71200400001)(478600001)(54906003)(6636002)(110136005)(82950400001)(38100700002)(82960400001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h8qIHyu433cuHxL/lUnaMfsBKU9vGNVUJ0b/YtEFLc4l+O0lxj33fsc90KWO?=
 =?us-ascii?Q?kOVqh3fqNCed53nR79KYDBPIxYs+X0w9lqXo3vwyAekyl36F+rh7acc14Fbj?=
 =?us-ascii?Q?9cG57zElR/6l6sgBvDHeX7+2zVKT/UNwaoKse84iqOGrrjA08vU3OcGX3HO4?=
 =?us-ascii?Q?pXkVQSK1qMJnRg15oxvvYubnae94hMMIrSFgJlNdX3YomOZ0jVk3RvBCVOnM?=
 =?us-ascii?Q?nXiM4oTARaaBrdxZHYec/zN70VYgAo0yhOuXvHhD4KTcOUUSPdesd8EEyX1u?=
 =?us-ascii?Q?A6zgmEwAzomGMn/54kSWIDn/b5WJjwII/rsiliD7FDb+0p/twcrORZlf2fCG?=
 =?us-ascii?Q?j5BFZYVYiDjCeHI0rG2nvmlbFha7uxNPV8uwY1n3HxITcA+F/7QNNxl1nWVb?=
 =?us-ascii?Q?LhvwixVPxL2XnG6BU5YXOzBIVRrWdEJRQEjKbKKEEgqJ+cPFDXXJmvVsC80C?=
 =?us-ascii?Q?luE7zsSRmQ9LOISuIjyihG9thj7BJ4rIeO9fDA2oMbalENfiLmRKC3UI+7Zu?=
 =?us-ascii?Q?sXuJLUO32LUlQ4VeZGF3FZI3yPqGdjhDsDAo+8kj5ZVHWl3u0bR/vxhyAF+/?=
 =?us-ascii?Q?OfYPYDXokhEHBpxqB1JZj4xiqWRFGpT7fg+dHmjw6cazaiwVhkUc0n+Hb+31?=
 =?us-ascii?Q?DguM3GSJIW6kgKgFeSAMi/DTX6/TWsMRcdZmmyGDl6KdbqxE7PHwW1EGCHx3?=
 =?us-ascii?Q?YqM1a08Om8y1Sk2+3SQTbaR1x6eUifw98TTrNx6r2b5Be0Q3x0DeIVUIvI4g?=
 =?us-ascii?Q?CqPk9UT/q3l8Q2UKTSQb2w2Nnk9qgbLYDMndgq9DN3NFB/PxTmo0xpEbWW9H?=
 =?us-ascii?Q?AIzOw/4CUy0q+CB3AX5WN/vO6Y8LtoY1K4vyd7Fi4lVhAZI8N2xWQZxs7FV7?=
 =?us-ascii?Q?Q2oXzL7FO65hZELP/tX0ef18+K6bj6yOSQbDmttiEO+PKeYRekQOt0r9VCm4?=
 =?us-ascii?Q?szYDru91w97tzHfkQHXmc549SM/p4LiTbh3z7HsK2Q7p2afoyplfUwlmFTYh?=
 =?us-ascii?Q?kSRDfUIku2SbtOOLXGzEqKBiFt6wDgfRPVWRuNFSSv5/iJ32iRhfFmz3lwJg?=
 =?us-ascii?Q?kkli9XUv7+Xw+42Yu8MOm+jnO35R34z8NBE8+iC84ott11MsGWReaqlyvKRp?=
 =?us-ascii?Q?NbddYIWr7DbuODTVMLfcotz1C2HVLscz96rzcHaNKzeRuYSuygcKCNvstvD6?=
 =?us-ascii?Q?i3hod5hHByQ9gZnTt6kvBnOzHKgYN4WNoXYd1ssG/O49BXV0nuQyX5jEM1O7?=
 =?us-ascii?Q?msmh65+o0YEQVJkcfCx91Bjbsqd0zNt1jNTYfq8SPmNqkD8j+YmPbLjFQQT0?=
 =?us-ascii?Q?mhU3LRoB1bExd/wEk4tQge1aHj3EjRGs/9/cY7VKNi1NCnLIKuHWCVx5OKn0?=
 =?us-ascii?Q?vfyRwkEUKoPbB0Wtbpqul7l6OUsOhczVPNRW8bA0QP22pMA8qeXOQ4Huq2n8?=
 =?us-ascii?Q?U5cXQzxplVDYtFSb7rUwLwpOHN4f0sBildFibzMza+YTc8uJKlBXJskRxFDc?=
 =?us-ascii?Q?Tyq77dacfa+Ur+E7q0jTkGbljSDCQ5PcL5PuOSAqK81+uBnroxs8VpAL/67p?=
 =?us-ascii?Q?Wbf6iFGT+SqlFKZwO/Hg2ugq/SZq6ZN0WXrZX0HJR4OeppddhU5Tz9sWyE+x?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c261da-499a-4a54-9c6a-08dac40585dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 16:55:22.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtPMyYnpz+z7ZJVmDjlytidmJ90zvJ56Gz2u6NTgLeWIfEZ5064aolTEwwtKFeivv/tFxHuDRgvnc5wRQT/axxg9J9XSKxCCbTD7oT9qm3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3110
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 8:33 AM
>=20
> Hi Tianyu
>=20
> On Wed, Nov 09, 2022 at 11:07:33AM -0800, Nuno Das Neves wrote:
> > If x2apic is not available, hyperv-iommu skips remapping
> > irqs. This breaks root partition which always needs irqs
> > remapped.
> >
> > Fix this by allowing irq remapping regardless of x2apic,
> > and change hyperv_enable_irq_remapping() to return
> > IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
> >
>=20
> Do you remember why it was x2apic only?
>=20
> We tested this patch on different VM SKUs and it worked fine. I'm just
> wondering if there would be some subtle breakages that we couldn't
> easily test.
>=20
> Thanks,
> Wei.

My recollection is that originally Hyper-V provided the x2apic in the
guest only when the number of vCPUs exceeded 255, and that was
the only case where IRQ remapping was needed.  The intent was to
not disturb the case where # of vCPUs was < 255 and the xapic is used.
I don't remember there being any potential for subtle breakages.

I think more recent versions of Hyper-V now provide the x2apic
in the guest in some cases when # of vCPUs is < 255.

Michael

>=20
> > Tested with root and non-root hyperv partitions.
> >
> > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > ---
> >  drivers/iommu/Kconfig        | 6 +++---
> >  drivers/iommu/hyperv-iommu.c | 7 ++++---
> >  2 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index dc5f7a156ff5..cf7433652db0 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -474,13 +474,13 @@ config QCOM_IOMMU
> >  	  Support for IOMMU on certain Qualcomm SoCs.
> >
> >  config HYPERV_IOMMU
> > -	bool "Hyper-V x2APIC IRQ Handling"
> > +	bool "Hyper-V IRQ Handling"
> >  	depends on HYPERV && X86
> >  	select IOMMU_API
> >  	default HYPERV
> >  	help
> > -	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
> > -	  guests to run with x2APIC mode enabled.
> > +	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> > +	  guest and root partitions.
> >
> >  config VIRTIO_IOMMU
> >  	tristate "Virtio IOMMU driver"
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.=
c
> > index e190bb8c225c..abd1826a9e63 100644
> > --- a/drivers/iommu/hyperv-iommu.c
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -123,8 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void=
)
> >  	const struct irq_domain_ops *ops;
> >
> >  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> > -	    x86_init.hyper.msi_ext_dest_id() ||
> > -	    !x2apic_supported())
> > +	    x86_init.hyper.msi_ext_dest_id())
> >  		return -ENODEV;
> >
> >  	if (hv_root_partition) {
> > @@ -170,7 +169,9 @@ static int __init hyperv_prepare_irq_remapping(void=
)
> >
> >  static int __init hyperv_enable_irq_remapping(void)
> >  {
> > -	return IRQ_REMAP_X2APIC_MODE;
> > +	if (x2apic_supported())
> > +		return IRQ_REMAP_X2APIC_MODE;
> > +	return IRQ_REMAP_XAPIC_MODE;
> >  }
> >
> >  struct irq_remap_ops hyperv_irq_remap_ops =3D {
> > --
> > 2.25.1
> >
