Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B7B76D5FA
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjHBRs4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjHBRsX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 13:48:23 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A7730DB;
        Wed,  2 Aug 2023 10:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAwk0UeH87QBrsAacK6RFvYAwlnvWyk8MBQfqPJZW78BVA7FxOpLSJgvBXdpu0cFI2DKaOoHvtJeTnwDXGIWluD6lbrABJ6jo1AfL2crvAQXEvPwm341hO6YY6/WXJiWhEunfCld8dzSSlF8jsoDxbARnIaCCDeByS0Al20CoVQ7mHmmHMV+qvfUZ5VEAdaY2Iyy81uLW4O1plnMQOlCxRdi88mEqNip4sifOd5CH03+5PMYWPLU9TNuwD5yS7vSME97aa0b18wCHz0tqjfFp+KGXGUQu4HjkwvO13DhaxIP6DYiiWXWoyVleZvx1dQ5CJtmW8EuDA7CtKlQ/YADig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yREP1gm3Q+Y4vso1mlc90UnO5BBHwbfTIMM0R/TuDiM=;
 b=L70TzTnNkzkwV68mw2/NNueMNT+4wcN+iORBNvzu0yWMo65iwL6eUjelSiEev/PkFCNItBgm0806IQ42IDDOVB6KA46R5wHne07j8Z8uCYPs8O7Ndw9Vm/iLwbbbCn/wv0B0/A7qE678D4llUwygzaCht1QZiuBxbblF7rf2vgIOJWKnE4VqKtNx39Er1vB7u+wTWfhqX/Iyns1ytsxon/0/rO5/vDqccBLISlLSGAcicY67TRG9oh9GaavUslEP8G5p2LtrDmr56Xzl1dtz40+bEQ4Gme/ED+jYz83ozg21/7BOfs0rZchhg8+bH3L3pqCsgWWkwrNInIN6aX9erg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yREP1gm3Q+Y4vso1mlc90UnO5BBHwbfTIMM0R/TuDiM=;
 b=KyWAq3/mW/UQm34TLi1K+pJnRYnyTsR16MeVJHAnVcmsD/RB74TkrdkmIMRtueJmMDsu8ghFTukN1ukNIl4J9ODbgVLcFNa21FbdGdE1sWceaoQsejEWDcPXLGsnkC1eUM3i/7uGxwdOlbd27OTkGU+gQTzk9HrD0Y4+0/tEzN8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3946.namprd21.prod.outlook.com (2603:10b6:510:24a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.6; Wed, 2 Aug
 2023 17:47:55 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 2 Aug 2023
 17:47:55 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "levymitchell0@gmail.com" <levymitchell0@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikelly@microsoft.com" <mikelly@microsoft.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH] hv_balloon: Update the balloon driver to use the SBRM API
Thread-Topic: [PATCH] hv_balloon: Update the balloon driver to use the SBRM
 API
Thread-Index: AQHZv1d0yHRwyuNfyUabzxLfRPMEe6/XS4YA
Date:   Wed, 2 Aug 2023 17:47:55 +0000
Message-ID: <BYAPR21MB16889DB462CEA394895BEBDBD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230726-master-v1-1-b2ce6a4538db@gmail.com>
In-Reply-To: <20230726-master-v1-1-b2ce6a4538db@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8558535d-1fed-4ed1-b3db-0f9829f2e5fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T17:16:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3946:EE_
x-ms-office365-filtering-correlation-id: a8fa2baa-76ee-42aa-ec7d-08db93809a21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUqZ2ypM3dU0dsW1KuPz94Ep5St5aSJ77o/HqQtir3KDfiCkMPOC2p40oG0kHdRV3Q8Qtm0nj31KsBtnZzq5JZ9N3Q+P+isRyqwTKHnPut74E0IriIxACt9mo63gGnH6RE/F8DxEklZvbkMGEe5bkozVBJOZB0kjjsL7XgwRNFVQ/Mse+YE5ynWb/iFjsdQiKeM0eJ02Y1w20js08lULpM/0gvpBFhTs+Qtwq9yHf/3D6Sxr8PbOwbzzntsaA6tIgyfnvnn2IvSwd1Rvlr9xB4H3bxQCqwGZB5FrK4yxnCOavrH5pcNTrFnPGgiPkognBUs96ES3GLrgC1tRzd1PdHr08/zaKoWaLnJiW852UeDGkWT9LnxzrCGWZq3swR/ToE9NrTSom9PpYdxvvoNvB/g8jORnaZcE1iB10UNw+rx1IfmOyRuNKLpSQPnUanvnCrW/2g2Jv9fMmj4r+DdQLlqTCqSjqCJfbbRa8jDJQvclcD6NViE4wMmI4ZpynmkcPsZsMX0lxMWvGmHxXKuc1qo4j84iTLnARplFPOLcFzGEDFtI2FbZpoHmktCM3Umzt8WV0iOon30FFTAkN/+OEdUrjqZGK7odcpBQhGV11f5suANlAskuH1J4K1vpn+xpZdsUPhomg2GPJF7T2Jzq+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(15650500001)(2906002)(66899021)(8990500004)(83380400001)(55016003)(71200400001)(38070700005)(66476007)(76116006)(64756008)(66446008)(66556008)(66946007)(786003)(6636002)(110136005)(54906003)(9686003)(86362001)(33656002)(316002)(10290500003)(4326008)(7696005)(122000001)(478600001)(8676002)(8936002)(966005)(52536014)(5660300002)(38100700002)(41300700001)(82960400001)(82950400001)(6506007)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pt61rbIq90FMbQ9V4qYWeDDZoMV/HTj3lJOG4kTYZIxsaB9+I9m/ztb3pNLM?=
 =?us-ascii?Q?D7ISm9m28MKAxSqgISa10xJXclSQbn4hh1KV+WZHKT7Px5Ec3Vs5/p0cKrdC?=
 =?us-ascii?Q?T6mmeAQzmsDuRMBq93xiUs96rE67euT4WVUhhM8xJwa2ewV20PGTR2SlrrAv?=
 =?us-ascii?Q?FFULPxCNll91PFe3Towkxxh22TlaHKARTyW1ayBonz2H+p+3IF91yEaBa7j0?=
 =?us-ascii?Q?BxWR22TGFNo0tRVQuZxfmuiUkDNpAQ9+JbSopqybHoJG4LepCHbq05Q8mikM?=
 =?us-ascii?Q?JrU3Gode0PL6ILT3UTGrVTaj6zHUNseLnl17RP8Eojgvha8GWpb9vGjd+YoH?=
 =?us-ascii?Q?oh3mYMrmjZtF1x4xdW7T5a3oOvPQXOh1r7+sZs2p6aopiSX8WkK4bOTbkX03?=
 =?us-ascii?Q?qHgvWzhcV6ef35UZL7TEVrHRZR6sMcpHEGMbAavSSfixEElWHDpqMvR/Fj1Q?=
 =?us-ascii?Q?6QkFZoNjKrw7OCdIRQ7UKJdrteT7TR6U5nG6Oj4QcZmeQgAWNjPXppfhvUUv?=
 =?us-ascii?Q?Gw12+j3IYyABSkO/1ceykFDRBVFPI+ewncJE6AoQoMXRMFYXlR4PDDbJIebF?=
 =?us-ascii?Q?4pxErxxnIKMB1zO2s03T9DvqzLoHzrJdcgrZE7eJ0AJPcYGA86iihimR+V/M?=
 =?us-ascii?Q?MegTqvrBl13K2f3K931NF9qIgWY/1Uf7FAfJ1qTYmo2V8xDGy7lsQKer1jpk?=
 =?us-ascii?Q?C23vUPh6+MJfbFdF5ZdDeWQkGbHUklDUHRypm0SuuPqVBREM1VPswoW3O/Q9?=
 =?us-ascii?Q?FDJuE75HZQjdxRwbyHyyQ5ntIwwAYyGtKpHNwKStQmLlFu9qnPQvdS2mubV/?=
 =?us-ascii?Q?8MTJNxPsow2Sf+w3IgIdpkefYGqjHTcJnQNm8+Oe68kEG9p6qRmRMF1xeb1m?=
 =?us-ascii?Q?e7r88ypF6IwlxIeT8eCygblBCyUM7YNyk9Bqq5Q2ec+oblHuunOHSQJWnD/L?=
 =?us-ascii?Q?tjAXaiKyipaBDPQsGVcMWq0fihEpNeLccNvz4i+wLcieHoO3hRWuXuq6K/gH?=
 =?us-ascii?Q?1PuGnQwvlcoC7oepIIWLV8an+5g9DbEDvLmGmq0agGki0To0cVxCN16DIwd6?=
 =?us-ascii?Q?Gt6Jbqiaof2x/Tr3xnVu8ygjjtmQYTG9MuyqpdK3U1YQOCRWELt6kuHovqbU?=
 =?us-ascii?Q?dsguJcomDoKVnzxU+NHdvGcxdVdO/bxk06lXXuxefVpfYH8tBo0SQB4ZKoMc?=
 =?us-ascii?Q?2jGHh0/NCptpXtnINZuw0qgpR8trBq5kqOEjAnSQ4gxCT9OQnSJIjVlGTfL5?=
 =?us-ascii?Q?bluitPA7924ytrwecrxfTYse1ornzBLofFt/HX9AHZpiMrlFQFk5cVAiGx8S?=
 =?us-ascii?Q?Or/fEHTXI2bnacf4kj6P+lg7szSzUzPsZRU9KvH2OUMk1a9cdZj/9k+87kR6?=
 =?us-ascii?Q?xLiDUg/YGLUHsKo9dtJxx/Bw5EhJfG8XycjUJavWfJv+cBhSZM1+IfHLtINn?=
 =?us-ascii?Q?2amnBFTQvZ5Kdmr3caxfbbCQv5lAjyJ+zquEm3QQG8qnl1M0KraDscCG4RjE?=
 =?us-ascii?Q?zeV0JWbO62gr9WAbzuNe+ZcokFrslbufHDdu/zjkUiNeYq9dU0rVaQZRa/ee?=
 =?us-ascii?Q?EALO4Ve1ZpOk6VX3YIkrUZnmhjCN8TFapCDoCmgpFcuifb4W9edHo5BIbkgk?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fa2baa-76ee-42aa-ec7d-08db93809a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 17:47:55.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpNJfrJ6zpxQE0gPQx0wvLD+wOcM+Bh/nAwI/Kcx58WncC+A2Zpl4LYmaNAXGn/NTrV63kZdgQyhAj/sr/AzNohK3X0G0i1hKjM0/WpQzFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3946
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.or=
g> Sent: Tuesday, July 25, 2023 5:24 PM
>
> This patch is intended as a proof-of-concept for the new SBRM
> machinery[1]. For some brief background, the idea behind SBRM is using
> the __cleanup__ attribute to automatically unlock locks (or otherwise
> release resources) when they go out of scope, similar to C++ style RAII.
> This promises some benefits such as making code simpler (particularly
> where you have lots of goto fail; type constructs) as well as reducing
> the surface area for certain kinds of bugs.
>=20
> The changes in this patch should not result in any difference in how the
> code actually runs (i.e., it's purely an exercise in this new syntax
> sugar). In one instance SBRM was not appropriate, so I left that part
> alone, but all other locking/unlocking is handled automatically in this
> patch.
>=20
> Link: https://lore.kernel.org/all/20230626125726.GU4253@hirez.programming=
.kicks-ass.net/ [1]

I haven't previously seen the "[1]" footnote-style identifier used with the
Link: tag.  Usually the "[1]" goes at the beginning of the line with the
additional information, but that conflicts with the Link: tag.  Maybe I'm
wrong, but you might either omit the footnote-style identifier, or the Link=
:
tag, instead of trying to use them together.

Separately, have you built a kernel for ARM64 with these changes in
place?  The Hyper-V balloon driver is used on both x86 and ARM64
architectures.  There's nothing obviously architecture specific here,
but given that SBRM is new, it might be wise to verify that all is good
when building and running on ARM64.

>=20
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: "Mitchell Levy (Microsoft)" <levymitchell0@gmail.com>
> ---
>  drivers/hv/hv_balloon.c | 82 +++++++++++++++++++++++--------------------=
------
>  1 file changed, 38 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index dffcc894f117..2812601e84da 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -8,6 +8,7 @@
>=20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
> +#include <linux/cleanup.h>
>  #include <linux/kernel.h>
>  #include <linux/jiffies.h>
>  #include <linux/mman.h>
> @@ -646,7 +647,7 @@ static int hv_memory_notifier(struct notifier_block *=
nb, unsigned long val,
>  			      void *v)
>  {
>  	struct memory_notify *mem =3D (struct memory_notify *)v;
> -	unsigned long flags, pfn_count;
> +	unsigned long pfn_count;
>=20
>  	switch (val) {
>  	case MEM_ONLINE:
> @@ -655,21 +656,22 @@ static int hv_memory_notifier(struct notifier_block=
 *nb, unsigned long val,
>  		break;
>=20
>  	case MEM_OFFLINE:
> -		spin_lock_irqsave(&dm_device.ha_lock, flags);
> -		pfn_count =3D hv_page_offline_check(mem->start_pfn,
> -						  mem->nr_pages);
> -		if (pfn_count <=3D dm_device.num_pages_onlined) {
> -			dm_device.num_pages_onlined -=3D pfn_count;
> -		} else {
> -			/*
> -			 * We're offlining more pages than we managed to online.
> -			 * This is unexpected. In any case don't let
> -			 * num_pages_onlined wrap around zero.
> -			 */
> -			WARN_ON_ONCE(1);
> -			dm_device.num_pages_onlined =3D 0;
> +		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> +			pfn_count =3D hv_page_offline_check(mem->start_pfn,
> +							  mem->nr_pages);
> +			if (pfn_count <=3D dm_device.num_pages_onlined) {
> +				dm_device.num_pages_onlined -=3D pfn_count;
> +			} else {
> +				/*
> +				 * We're offlining more pages than we
> +				 * managed to online. This is
> +				 * unexpected. In any case don't let
> +				 * num_pages_onlined wrap around zero.
> +				 */
> +				WARN_ON_ONCE(1);
> +				dm_device.num_pages_onlined =3D 0;
> +			}
>  		}
> -		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  		break;
>  	case MEM_GOING_ONLINE:
>  	case MEM_GOING_OFFLINE:
> @@ -721,24 +723,23 @@ static void hv_mem_hot_add(unsigned long start, uns=
igned long size,
>  	unsigned long start_pfn;
>  	unsigned long processed_pfn;
>  	unsigned long total_pfn =3D pfn_count;
> -	unsigned long flags;
>=20
>  	for (i =3D 0; i < (size/HA_CHUNK); i++) {
>  		start_pfn =3D start + (i * HA_CHUNK);
>=20
> -		spin_lock_irqsave(&dm_device.ha_lock, flags);
> -		has->ha_end_pfn +=3D  HA_CHUNK;
> +		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> +			has->ha_end_pfn +=3D  HA_CHUNK;
>=20
> -		if (total_pfn > HA_CHUNK) {
> -			processed_pfn =3D HA_CHUNK;
> -			total_pfn -=3D HA_CHUNK;
> -		} else {
> -			processed_pfn =3D total_pfn;
> -			total_pfn =3D 0;
> -		}
> +			if (total_pfn > HA_CHUNK) {
> +				processed_pfn =3D HA_CHUNK;
> +				total_pfn -=3D HA_CHUNK;
> +			} else {
> +				processed_pfn =3D total_pfn;
> +				total_pfn =3D 0;
> +			}
>=20
> -		has->covered_end_pfn +=3D  processed_pfn;
> -		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +			has->covered_end_pfn +=3D  processed_pfn;
> +		}
>=20
>  		reinit_completion(&dm_device.ol_waitevent);
>=20
> @@ -758,10 +759,10 @@ static void hv_mem_hot_add(unsigned long start, uns=
igned long size,
>  				 */
>  				do_hot_add =3D false;
>  			}
> -			spin_lock_irqsave(&dm_device.ha_lock, flags);
> -			has->ha_end_pfn -=3D HA_CHUNK;
> -			has->covered_end_pfn -=3D  processed_pfn;
> -			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +			scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> +				has->ha_end_pfn -=3D HA_CHUNK;
> +				has->covered_end_pfn -=3D  processed_pfn;
> +			}
>  			break;
>  		}
>=20
> @@ -781,10 +782,9 @@ static void hv_mem_hot_add(unsigned long start, unsi=
gned long size,
>  static void hv_online_page(struct page *pg, unsigned int order)
>  {
>  	struct hv_hotadd_state *has;
> -	unsigned long flags;
>  	unsigned long pfn =3D page_to_pfn(pg);
>=20
> -	spin_lock_irqsave(&dm_device.ha_lock, flags);
> +	guard(spinlock_irqsave)(&dm_device.ha_lock);
>  	list_for_each_entry(has, &dm_device.ha_region_list, list) {
>  		/* The page belongs to a different HAS. */
>  		if ((pfn < has->start_pfn) ||
> @@ -794,7 +794,6 @@ static void hv_online_page(struct page *pg, unsigned =
int order)
>  		hv_bring_pgs_online(has, pfn, 1UL << order);
>  		break;
>  	}
> -	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  }
>=20
>  static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
> @@ -803,9 +802,8 @@ static int pfn_covered(unsigned long start_pfn, unsig=
ned long pfn_cnt)
>  	struct hv_hotadd_gap *gap;
>  	unsigned long residual, new_inc;
>  	int ret =3D 0;
> -	unsigned long flags;
>=20
> -	spin_lock_irqsave(&dm_device.ha_lock, flags);
> +	guard(spinlock_irqsave)(&dm_device.ha_lock);
>  	list_for_each_entry(has, &dm_device.ha_region_list, list) {
>  		/*
>  		 * If the pfn range we are dealing with is not in the current
> @@ -852,7 +850,6 @@ static int pfn_covered(unsigned long start_pfn, unsig=
ned long pfn_cnt)
>  		ret =3D 1;
>  		break;
>  	}
> -	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>=20
>  	return ret;
>  }
> @@ -947,7 +944,6 @@ static unsigned long process_hot_add(unsigned long pg=
_start,
>  {
>  	struct hv_hotadd_state *ha_region =3D NULL;
>  	int covered;
> -	unsigned long flags;
>=20
>  	if (pfn_cnt =3D=3D 0)
>  		return 0;
> @@ -979,9 +975,9 @@ static unsigned long process_hot_add(unsigned long pg=
_start,
>  		ha_region->covered_end_pfn =3D pg_start;
>  		ha_region->end_pfn =3D rg_start + rg_size;
>=20
> -		spin_lock_irqsave(&dm_device.ha_lock, flags);
> -		list_add_tail(&ha_region->list, &dm_device.ha_region_list);
> -		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> +			list_add_tail(&ha_region->list, &dm_device.ha_region_list);
> +		}
>  	}
>=20
>  do_pg_range:
> @@ -2047,7 +2043,6 @@ static void balloon_remove(struct hv_device *dev)
>  	struct hv_dynmem_device *dm =3D hv_get_drvdata(dev);
>  	struct hv_hotadd_state *has, *tmp;
>  	struct hv_hotadd_gap *gap, *tmp_gap;
> -	unsigned long flags;
>=20
>  	if (dm->num_pages_ballooned !=3D 0)
>  		pr_warn("Ballooned pages: %d\n", dm->num_pages_ballooned);
> @@ -2073,7 +2068,7 @@ static void balloon_remove(struct hv_device *dev)
>  #endif
>  	}
>=20
> -	spin_lock_irqsave(&dm_device.ha_lock, flags);
> +	guard(spinlock_irqsave)(&dm_device.ha_lock);
>  	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
>  		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
>  			list_del(&gap->list);
> @@ -2082,7 +2077,6 @@ static void balloon_remove(struct hv_device *dev)
>  		list_del(&has->list);
>  		kfree(has);
>  	}
> -	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  }
>=20
>  static int balloon_suspend(struct hv_device *hv_dev)
>=20
> ---
> base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> change-id: 20230725-master-bbcd9205758b
>=20
> Best regards,
> --
> Mitchell Levy <levymitchell0@gmail.com>

These lines at the end of the patch look spurious.  But Boqun has
already commented on that.

Michael
