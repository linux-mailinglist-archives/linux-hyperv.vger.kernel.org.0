Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F633619D09
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKDQXP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Nov 2022 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDQXO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Nov 2022 12:23:14 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2442FC18;
        Fri,  4 Nov 2022 09:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6AtNtghgARAKMapLu7xJC6GqCML+xLsgEA547e0jNBkvHpAZbRDQwVp13Iw7sqUO6U/G19N8ENM0rNq2Fcza35ggX5uL7GQUFT2RBPqKCRxnuZya1ihzxhI4O89/5YCZcNgnkeIzmD5/Eeei60B8AgU9lT6prusfPNmdU3pSvWKfGJ8y6aZcPVGNpeN4bLDaScjEtTtLiVU0Wgsj0Pxkn6NLsdBupdevPbuK8R3r4UUQFFvI/O7R/a8uPV0FWyPLHgnKZeHqjLCeI2GPja19/ojFPZEYgImAxBrcYRhW0GA72wKABUSJLx0301D8YN+WARPBlMVHcIraDKrGjjFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA99SaH9yakrSuNucwRK3csD1cQCKYdEJGpllOZeyXY=;
 b=APQlFMuJ2wxXsriRc8U/r5A5TwMlUoJ4F/V9/XWBqStJ44mnOXAnVGlKrgPk3wkENr7SJQ4w3glU5DkneS2HWPYAHM0T9YriW8Ddkc7ayds+UqHrJzBIvgkOhwsXhQmUfMJoDRBq4qSfMw89L1L11jE/3i94cbkbyV+VAGK9JLthgU/GqFohxZwO/dQXpLgfj/JGpYUzzG46xVa2ndVvS3DrOkiEVqk6XzJObbAlK0C9LRiBuAa0IP7dffh+7tbq5kWNVzg8ysrTRU5tQvp/ZhyxgTmjI3IOlKvOr8OOhnUVCFc81375nH/FbcmfuB1b0p+fV2sKttKsUOdfLz5P4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA99SaH9yakrSuNucwRK3csD1cQCKYdEJGpllOZeyXY=;
 b=fJ86xW9Nt3SmFvN/VCqhYX0fwNvVH4u3yNKVKg/W3/uZg4wzUbH+7SswfQM8qVSWxwumnjZJiaCak0T/6JtkTFhZcZ1kkVs2anCN8vJpZNDPKgULIqHx16E3YwSZtby4jH0vThQxoO9r1ABo6PunnxGkWbZmwE7h77PeL/we7Ao=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA1PR21MB1302.namprd21.prod.outlook.com (2603:10b6:806:1e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.9; Fri, 4 Nov
 2022 16:23:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Fri, 4 Nov 2022
 16:23:08 +0000
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
Thread-Index: AQHY77dXy9yFR2n9S0Oj8F1qxUZhgq4u8ROA
Date:   Fri, 4 Nov 2022 16:23:08 +0000
Message-ID: <BYAPR21MB1688482206965765C716DC9ED73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221103190601.399343-1-vkuznets@redhat.com>
In-Reply-To: <20221103190601.399343-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=17662be7-7da5-4303-bb70-52e1b49a0ed5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-04T16:12:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA1PR21MB1302:EE_
x-ms-office365-filtering-correlation-id: 722f7846-b135-4cc2-8138-08dabe80dc59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EfTEXWGKsRWevh5PGXwby8tixkXHzj5ZrE+ydWzWrKImce6u1+wW7UkYKPcNs6oMTE7+Jo3O2ITnATujSJVHJD+sce2gLXRswf26bcXFBV/duCPAA4SksIILD0Hiy0Q7yqzerQ2QKrctwkWiUrijZHcV+1SmYPV/Tit62xpW3xo8kvf9eD8K82G9/byoyizQYY3ZlPKtNSWaTL6bDn5C4Sfu0anQGzD6Ohur4I1dVgqi1zmQ0HGzQsWHWAKyGZm6xXXs4N9bEhXUY5cpH3Kl1dgMSHZU+oEPWpLlhr6cRR+o2V0+0SG4s049XhcPYfz2Rm4aqZ3HyV0wBxKf1C4qmoPXt8U0Vl0DDMHmGzcM7efQ8kXtycM6gw2EOtEruMqm3gr7AD63a+TxbzBahz9ReNY8t+EhKsRR7vJA+jE6T8BBfk1M7Srwh2BTIvR8PjkW56c9YeKRaAVcrYHEppFpVnVYNGzQPhgcp9GMKFEHCEIKGyuXFDA5lvJL2nvNvRlWz9TFPhxc7RSg/+pl/KReBSrQ0jrRiqF5u+fu/Wfhxq4ssbUIx6rIp0AelNqUHoqNYukWOAB/sNCsvodHxf2jsvWxNR2YJLAZS2OjBk1yezvznvOePuNacIpCAoPztbsc9nwwQaZ7dV/sIKUotwQd1fefhI4DdHTmC93AEjap0ZPByrFfRa4psT6DHYLnCGt4jEuSqU3nCjDCR/yyGUbLqzqEVsQ/R3XbtGp0fM8IPLzfVa/m5N3IBBKeeQ4s137iGpDIXVzYhL9yAvEA62xPWgiRP1iRpf7idWyxU/Ix/p9X0lwVBdTfn3F2EC0XgbJi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(7696005)(6506007)(41300700001)(9686003)(316002)(83380400001)(52536014)(8936002)(33656002)(8990500004)(186003)(5660300002)(2906002)(66946007)(38070700005)(64756008)(55016003)(76116006)(66556008)(26005)(4326008)(8676002)(71200400001)(66446008)(66476007)(478600001)(82950400001)(82960400001)(122000001)(10290500003)(54906003)(86362001)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xymiDD1Rm63SHlj4NUKJpp14ndyobEeU33ctE0TtriVkGKb2D2BypXzIlm6I?=
 =?us-ascii?Q?GEuZfCcn7QaYq2CPQl0eoaeziQdAQaJkNOePEAmvkCoFujdBKWTYtmn5p4ZW?=
 =?us-ascii?Q?RxAaDvUEfYnYYj6IwF+XYvxxZhf0Pg3BVkLDW5ho7x+xiOFGhBkrfdKyju/m?=
 =?us-ascii?Q?aOkHfkYUi1sa0Hu0s6KrLhGNjC9Nso8h7EmWMXaVhV4L7jLjtmQVWjWN+A4Z?=
 =?us-ascii?Q?wS4ctntyFW2mGq9ToDEtz3Dwe3sX7ZSsTZ00xoHtbHwN/ZcQLfoEOzfBhFz3?=
 =?us-ascii?Q?Xjrldyor+gZrLUZsgb2M0sfAz32jp803SiIkfIkkYth80DRS30WYSj/MECFg?=
 =?us-ascii?Q?xJWuWGFDqY2XKmXd/AsxjkGNssOtig7j+V97j0mmPa3mWHtCT4S/2LlDFAPM?=
 =?us-ascii?Q?ue0dNG84FlHOln2ntc3Q0zcbnKJ3q5r/2KtZudm/ZufaLPw42qyLhRi7M7Vp?=
 =?us-ascii?Q?OFf5uYcOuWWvK4AQ1Ife6epbe7G4ym/IenmBq22vj/Xkegno18mgCKr1DkWT?=
 =?us-ascii?Q?X5ngqw0+rYOjNgUnGzbv18N8+qc5DnHriO868CovH0KZo08f2FU319BqhaRS?=
 =?us-ascii?Q?UNww8pTmXuBJtYOb/zl/E6MgVbzEaQkfXpNPcyPo4zvrnW61hHHDGLi99NSv?=
 =?us-ascii?Q?yho9T3JLFjMuTah2raPYlRv+BDPX+AYlG9w5BehtvjO+kFBaDaXl/MnBOrVv?=
 =?us-ascii?Q?HtcGTr1+wlwLmNfayX8yteZYzWXSuq4DE6LfzBHhCwWT6kaGCUErvj38D5Wf?=
 =?us-ascii?Q?QySlcOmYlAat5wfe3v052YHIA0TdsifJ2VvryKdg/PbIOxQHDL2bM7833ABC?=
 =?us-ascii?Q?bVeJL+Y8mjZV7HFt5aebtQAJ6DD7ngQG0DF0x8LMw9X+w8KgsUjuCY6mPBMd?=
 =?us-ascii?Q?y5RFvTrkIAhElqBcyaRQiAxbMSpvxjFwd2LEvTC9sywFAvnR92w3IqHrCXeR?=
 =?us-ascii?Q?tndAzDivyRRD2tW4mU5KtMX2uke77E6g4tqHjkwuYnbazkHxAbS6Smxjzv1K?=
 =?us-ascii?Q?bNBZcVlAhisrDD5m9DhpNPmWdPmb4PQiHb3B4DZPWTKbjq4P4fFSVc3O17eY?=
 =?us-ascii?Q?nNvwJ9RyTRGz98yNb8BAwnTQemx2A8YvgA2eP1bY/4TpjKKzK7KQhAhiAQ26?=
 =?us-ascii?Q?/4Z2y1BT5Hj0aWs+JE6wo2iSEE4HYOMWbVJZBHTb4WtYiraV4Bf89euIc2mA?=
 =?us-ascii?Q?U6H8y5HV23PQ2CcqigFP55BY1fGniqC8UHVZvF1AsUz1MtgXqnvE5/NY6oFZ?=
 =?us-ascii?Q?hBEo1YSQwiQglZ+Za28+895H13QDrlMStYazAc0Ue0o81uFXrc0gQ6uO0Bhb?=
 =?us-ascii?Q?gR7HmZrobd26twmrEGWyrx36jOCA9c6nzQD0ueR9kFQkAaK+n4kp74/DNWUH?=
 =?us-ascii?Q?S3gYHZF7crqr2AT1ngT17WJS54AzTurWW+wmbM/HKhg4+uWP+fcWltwfY+op?=
 =?us-ascii?Q?Y4KN8rUy0i6Hh7bCEzFoC+jfstUIEZUenyYUZ4uaQW8CLUlEZH56VbMC7ojp?=
 =?us-ascii?Q?5olvQ46uRyKKpqyFt7A9mPTB1Jw7vudWYm5qcvWze4jKvZIE8ow2ZGXxRox+?=
 =?us-ascii?Q?4/wUCfxhFLtFg3C8iiVUvoNCdhVxZU+11B+jJajD88TGYzsEpkPygUC2KHKr?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722f7846-b135-4cc2-8138-08dabe80dc59
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 16:23:08.7978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq44w3qus4b3fCW9qnQeLqxGvEdDZKxszABxO1ZoGh0wrnMwN6MI20lRub0DXo1VYs0x2EZtzxyGZBG8RQJiI/AdlOhgNBpVdIzIcP8qltM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB1302
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
> for them.=20

Did you consider having hv_cpu_die() free the VP assist page and
set hv_vp_assist_page[cpu] to NULL in the non-root case?  That would
make the root and non-root cases more consistent, and it would make
hv_cpu_init() and hv_cpu_die() more symmetrical.   The hv_cpu_die()
path frees up pretty much all the other per-CPU resources.  I don't
know why it keeps the VP assist page for re-use if the CPU comes back
online later.

You added the original code for allocating the vp_assist_page in
commit a46d15cc1a, so maybe you remember if there are any
gotchas. :-)

Michael

> This causes VP assist page to remain unset after CPU
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

