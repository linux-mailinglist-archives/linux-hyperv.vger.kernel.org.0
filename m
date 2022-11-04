Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7C61A2CE
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiKDU5p (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Nov 2022 16:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKDU5m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Nov 2022 16:57:42 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020014.outbound.protection.outlook.com [52.101.51.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA9E49B69;
        Fri,  4 Nov 2022 13:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXD72PV321+srq2nXI4FnKC4GmjaWu22i9Albe3Kmi+wdmluiwsvhYNTgDtkGFrB3xbwXoWX0Qrrf3lzEtfZ4q11vzkKHti1AvHu4NVHKzii7itKpUH4qiMnRrLhBgEOzV3EEazwkiODxKyupbPffZpk1MqwFlvR6xROh87XblRO0QP8WcPZaBGTyGaLOKoIKxeAymJlui6+irzz4zO4sWvdQ8iwptvQfa3WYm6puqwFIK2Ys45bsH7n0NWCwMW1lB55hjFots/18rzRzC+qEFWp3t7tpRt/igRju2kBhYj5YrQV1BWPKFN9orYIvUnrkmJsaNubNALZhq7ZzRiMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32D1lB/5meF/cgbhmQdnPPUZtSLGR36M7h/8UpYgi0E=;
 b=T6/KvrLtSHPgO02/rMz5zW8VYrjoulozENd8vWSak7fz1ncCKBZUyRwE60226Nn1AfedShkCh4ZfIjorEZUbSI9QZ1yJYIeo87qKSsopT+81W05SW4neaZJvU59UKkMHSHY619R2DY/8PvEsipYFfe+WgkC1ywmvS81N4kuNb5nwxSxc3pDdaWQV4Lgwg3jbBdvP9biBr0hvwpvrR+WpRn7MqDDz1q5kNo3+0qGv5rIhpbHQAltvuKwyy9STdfhyG1YfWdVH47Lr3Juc84Q9FBC/TFX6VQz0FAs4O3pYHKCgjk6CcSfLAAqZfkkoM5ZE0U31VqN0u0DVhoSOgW9Gzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32D1lB/5meF/cgbhmQdnPPUZtSLGR36M7h/8UpYgi0E=;
 b=YhkkRlyniVF2IH1SThP511gDr0FwlqLV30evEM6suvggjqUtOSTszDqkm65UaQWLVGrFwXdNGxTlXC4iiQ2/m2hmyTY0snvY3hHxuGx5M4W2M50Rz6zM1kXNtkskVDWNsqUiMBbg2afaRyN1SFI9NXP8gqG0Uvf9MvUewU54GVU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3561.namprd21.prod.outlook.com (2603:10b6:8:a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.5; Fri, 4 Nov
 2022 20:57:32 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Fri, 4 Nov 2022
 20:57:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/hyperv: Restore VP assist page after cpu
 offlining/onlining
Thread-Topic: [PATCH] x86/hyperv: Restore VP assist page after cpu
 offlining/onlining
Thread-Index: AQHY77dXy9yFR2n9S0Oj8F1qxUZhgq4vQIuA
Date:   Fri, 4 Nov 2022 20:57:32 +0000
Message-ID: <BYAPR21MB1688DC6D768475A393A06A91D73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221103190601.399343-1-vkuznets@redhat.com>
In-Reply-To: <20221103190601.399343-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f86ce496-a1a9-4697-80ab-55292af2e998;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-04T20:57:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3561:EE_
x-ms-office365-filtering-correlation-id: 6ef5f550-10fa-4368-9251-08dabea731a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ckvxoTNUY2ubYhZwfvAHQkQR+wKLx4AWv5oliFT5OL7EmlLWQkY+hUq2v8IEMmqchLxPyVtuU07+vuXhnYLQlDRJqEFOGwMJOAsY0gUSJupiMIyLmCGvww4hsKe7udn36Ih1UPMB8YJqlxfAUVU79y6lJNkijD5ThmuSMBhNwJbkCvbFXoFqPR/c4Kpp8BOn7UgJ6k/1CQBSdqnIYIO2fHWLpMx5eoarQU3/3M7eXCI8H4xw1mYNYyqHKGI2WqrtnsIfZ6IsGXWi5WnDu9cY91hJbo6Mn7mnWth9uP3guOjXfguIki91/dGvRHupJE12hjL+G9MVPpYZjGhFKnrIs2DHcztuL7BYNopPsUG1Wrr/o5v2goHt37v6nfsEJWdhlkp+FaFxupgrgkwzcIK94YkYDz3Rui5v9Op23gEIO+uz1a3Yg1WMYf9bjqI6XT7IpIZb6p2l79pwKZq8MIWXY4DyV1P8vgmk3k/nj/A0zgdyFkdzxKLE+w9svI8/QSRFJYfRyGfIza/nQBKTJvNsInxF/1dXrkhbmOseVXSj+YALtqxDwxy+A6P2Ao9mNo1lB46d1xlhC7EU5WkhaGoafTBAH6bYNftCtqRDDOJ3hSibEIG6zM7jjgSwgTK8BEJI4N06gkcVHVzNtY15QbhJOLnXh6ZBvlrR65dtv13s/wZfW8Iuqjnn8mnQOXD5EImX6JWZKnvF6oyjyiqitw1k05Q7T6sJq3A6Jpq4K2cXC98q1kzKrMUzZIE5c+eSh1nli7P55913DHhy3L60rrEK1Hej2GNHA3dQcReT34BxG8BBvcHKHTnporaDj1Dn7co0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199015)(52536014)(8936002)(2906002)(7696005)(82950400001)(8990500004)(110136005)(9686003)(71200400001)(54906003)(66946007)(66556008)(122000001)(66446008)(55016003)(10290500003)(76116006)(38100700002)(66476007)(316002)(82960400001)(6506007)(4326008)(64756008)(8676002)(33656002)(478600001)(41300700001)(5660300002)(186003)(86362001)(26005)(83380400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?63r5moKfOEsK+hun5qMPyzO6Lm/wksDYbPjNtahNVxEB10i0FrkOX6c9ds90?=
 =?us-ascii?Q?+MjzcMYU/NoLH6k0lb7tuxV2wSGtnsPslQGhbgjwu+eONt33TatylFvDwcS6?=
 =?us-ascii?Q?W05Un1kUjiHoSwjRtGAi2Tc7nhJ6qH+LwH7eySrHwU4gVQrlzOGzq3WFQ1XD?=
 =?us-ascii?Q?3/UU5KSeUDvHVxyAUt7cgYXrrtQ/L5tXTLUYw5wjolrVYWScHhQCeuORqPQJ?=
 =?us-ascii?Q?MaBDrXLR7+ItqsSDWxV3pGu8pBRPmTnt+r7Jerb51nhC3OpWRfoya9h7kJwz?=
 =?us-ascii?Q?XfGfq+BTUuuRlFd/LxvCM0J4NS0Zd6CVZQwDxpNjNnbEajUTtpFimR2VX269?=
 =?us-ascii?Q?qkeVxNN9OyOLWd/w4esoVF/bpSlFItJsSk/nEtgdGNlYiDyZ/zaO/d4V9qYW?=
 =?us-ascii?Q?s68n8nt48Ve/yUwB7fHrF7KomVlShuXJcWB41LQ00cqJx9kJbNyJjmIbRG9V?=
 =?us-ascii?Q?JfKmujKWHmluAPxGOoVi1KB8IRe3dl05nYeH2R+Zn/STg+yK+aW22HJ9F5FA?=
 =?us-ascii?Q?1K+Sr9jYUMxlut89TEwi4iS+3qDsFjwRmquLBN3oD1GYB3baEsxkpsZdXWB3?=
 =?us-ascii?Q?IgKagCRniX7jzT7SlCN72lx0773RMKecEYdw0mYXHMWtfXbGiIImD66hWDWj?=
 =?us-ascii?Q?2mZCwpfm1I9u9CPtdHA4pUd4EoftgOTm2oaaokpjPiKz2UrmKn61/sCAhXt8?=
 =?us-ascii?Q?uLYeM9l7kMOAdOfCbeJuy5+o2vmO93b3Pj4x1EhuFICX8W4Uz41ymZTY8aHL?=
 =?us-ascii?Q?xtb2Q3m1qbUCWkrtDRAQX0LvBRlWAztf3RF/dcj9zdrcg9xbUndiw3mtIuNd?=
 =?us-ascii?Q?Tv+n6VOE2r0O3pXHmlOs/5y5pd8urtzYwA9735EQvF0Q1CRPASx0WAHmGONm?=
 =?us-ascii?Q?2Q36nslpRjMNNWJCrFgOq/k4owlbiIGkmSfMYfMQ/ynFG/EbRNTgP7Uyj3+i?=
 =?us-ascii?Q?uYGUOo/DFcTrtWpw9aW277H2VDmSejAQPqG/ZvXXfoHBZrEIrpCRZeCE4MHt?=
 =?us-ascii?Q?Xk2uw5ZptzWwyu3WXr56UCSWMpafItcLbqeVBebEwzuaaONMKXzwD1yFcxiA?=
 =?us-ascii?Q?mcSLlWBIYBO14pExsifbnLFXqN8IPIZcrU5ZPmRuMuU64Fx4nHKB6NrMJ7MU?=
 =?us-ascii?Q?4snI8X4n71AfUQwjtv2z56zSaJbu9c5drU0ErCSlpYe+H3OQqOoR9VK38QNz?=
 =?us-ascii?Q?OD8tPFgXRY7vBaHa3H9ixOIEe8/eqraq3OfEN168SiGD9fPn927k0WR0kFAC?=
 =?us-ascii?Q?8vyPeOmQbB0t93fSYTHKXimTgdSJABdSHXmTxByzWsfUw51WoqXFc9wsUuCL?=
 =?us-ascii?Q?uawGdhPe4X3WEdK8CiTXXdol3EusWKojBIfqcc6ScVICmA4WhTufPe54ThJy?=
 =?us-ascii?Q?mJWsAvZKXjvBwCwzBuUGAaibOl4B+wRksX2/IGJPaS81nJsIrIWgQxlUCeeT?=
 =?us-ascii?Q?EO4u7v5RwURrzNBWevvJwesC8mqNB3jZAmoFQ+ibW1PZxW7ldaBB+pVp7maY?=
 =?us-ascii?Q?0D4Z9jmr3ut61754UxNXLY7mwBpTgw6VpdGWjEdCF2dGXoBsGNjvPUfUls5y?=
 =?us-ascii?Q?eMheuNN3PPxC19dIASvjggsI5sBOWRkEvpFhg1Cgt9nuXOigFCG0LopSYPst?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef5f550-10fa-4368-9251-08dabea731a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 20:57:32.7668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NG6kR/HndKsCbfSUV6axP6pB9lNoM2VE/XukM90sP+T4nkKNy1UuTnXbj4ZGyQ/zMxhQF8gyQFI8lZE/z6KqxwHZtKZrQ92kfCXEjC6UZ8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3561
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, November 3, 20=
22 12:06 PM
>=20
> Commit e5d9b714fe40 ("x86/hyperv: fix root partition faults when writing
> to VP assist page MSR") moved 'wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE)' under
> 'if (*hvp)' condition. This works for root partition as hv_cpu_die()
> does memunmap() and sets 'hv_vp_assist_page[cpu]' to NULL but breaks
> non-root partitions as hv_cpu_die() doesn't free 'hv_vp_assist_page[cpu]'
> for them. This causes VP assist page to remain unset after CPU
> offline/online cycle:
>=20
> $ rdmsr -p 24 0x40000073
>   10212f001
> $ echo 0 > /sys/devices/system/cpu/cpu24/online
> $ echo 1 > /sys/devices/system/cpu/cpu24/online
> $ rdmsr -p 24 0x40000073
>   0
>=20
> Fix the issue by always writing to HV_X64_MSR_VP_ASSIST_PAGE in
> hv_cpu_init(). Note, checking 'if (!*hvp)', for root partition is
> pointless as hv_cpu_die() always sets 'hv_vp_assist_page[cpu]' to
> NULL (and it's also NULL initially).
>=20
> Note: the fact that 'hv_vp_assist_page[cpu]' is reset to NULL may
> present a (potential) issue for KVM. While Hyper-V uses
> CPUHP_AP_ONLINE_DYN stage in CPU hotplug, KVM uses
> CPUHP_AP_KVM_STARTING
> which comes earlier in CPU teardown sequence. It is theoretically
> possible that Enlightened VMCS is still in use. It is unclear if the
> issue is real and if using KVM with Hyper-V root partition is even
> possible.
>=20
> While on it, drop the unneeded smp_processor_id() call from hv_cpu_init()=
.
>=20
> Fixes: e5d9b714fe40 ("x86/hyperv: fix root partition faults when writing =
to VP assist
> page MSR")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/hyperv/hv_init.c | 54 +++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index f49bc3ec76e6..a269049a43ce 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -77,7 +77,7 @@ static int hyperv_init_ghcb(void)
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	union hv_vp_assist_msr_contents msr =3D { 0 };
> -	struct hv_vp_assist_page **hvp =3D &hv_vp_assist_page[smp_processor_id(=
)];
> +	struct hv_vp_assist_page **hvp =3D &hv_vp_assist_page[cpu];
>  	int ret;
>=20
>  	ret =3D hv_common_cpu_init(cpu);
> @@ -87,34 +87,32 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (!hv_vp_assist_page)
>  		return 0;
>=20
> -	if (!*hvp) {
> -		if (hv_root_partition) {
> -			/*
> -			 * For root partition we get the hypervisor provided VP assist
> -			 * page, instead of allocating a new page.
> -			 */
> -			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -			*hvp =3D memremap(msr.pfn <<
> -
> 	HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> -					PAGE_SIZE, MEMREMAP_WB);
> -		} else {
> -			/*
> -			 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
> -			 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
> -			 * out to make sure we always write the EOI MSR in
> -			 * hv_apic_eoi_write() *after* the EOI optimization is disabled
> -			 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
> -			 * case of CPU offlining and the VM will hang.
> -			 */
> +	if (hv_root_partition) {
> +		/*
> +		 * For root partition we get the hypervisor provided VP assist
> +		 * page, instead of allocating a new page.
> +		 */
> +		rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> +		*hvp =3D memremap(msr.pfn <<
> HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
> +				PAGE_SIZE, MEMREMAP_WB);
> +	} else {
> +		/*
> +		 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
> +		 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
> +		 * out to make sure we always write the EOI MSR in
> +		 * hv_apic_eoi_write() *after* the EOI optimization is disabled
> +		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
> +		 * case of CPU offlining and the VM will hang.
> +		 */
> +		if (!*hvp)
>  			*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> -			if (*hvp)
> -				msr.pfn =3D vmalloc_to_pfn(*hvp);
> -		}
> -		WARN_ON(!(*hvp));
> -		if (*hvp) {
> -			msr.enable =3D 1;
> -			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> -		}
> +		if (*hvp)
> +			msr.pfn =3D vmalloc_to_pfn(*hvp);
> +
> +	}
> +	if (!WARN_ON(!(*hvp))) {
> +		msr.enable =3D 1;
> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>  	}
>=20
>  	return hyperv_init_ghcb();
> --
> 2.38.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

