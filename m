Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D10526544
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 May 2022 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378147AbiEMOxr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 May 2022 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353025AbiEMOxp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 May 2022 10:53:45 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4AB24092;
        Fri, 13 May 2022 07:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON4iRAnh7oIc1tnwGmGhsbrD0IS2TsQXzYYJ051HGRDiWrhbDEKcCwtlF7HOUjpWyjRJBvrviOyarVZLpa4mNm8NUROL72g9XCKcWKtJnBHJ+gWNlRQ9eWJHkT373fU3cbqb99PaszH+c3SFk165Q5BOL7p9/NaFyUVJZL5HsIONIeO5NbQ856txGK6VvlaBfTlzvMo9uDOghnSKtkFRmYjYCn85IagiVlPheGK0Sj4RrdAosPNtMtVjKRx6ZvLoL5x5TvKaayrY8o5UNUorZQ1IGL4CVvGOQ8v48NeH6kwxD906Sc0DKI4fnGo9TPHBk6Uz9svDI8Uwh6TN9i4Vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvt2FGpK7u06qe5LqV4RSywhF/4HAWqE6HniGltbJM0=;
 b=ewDAEnxUrz7hpFkHyNkLMSvVjhuXuzA4GRixkF3tWZwEeKdRgGQK6Fbzr/suGKGi8Z3Nfmf69v/JYobo5rKNSkRTfaLoxASPZybNAKfiSNW0usuZN2wvtPuxEwiC5Cx4VJnp/4oCGMcTw6vOrl+1A505kXHtvn3Px9cgD/PlXjtoFKr/XIuvimUz1M2sCq7rggeYxiyFgw19kfvDL0WUWwSqxSREA9IoHzuxq9Q+RVXWxQTxSrn0l3dJ0Xs/YhBV+ljmQGzIGenQgBvfMB25c9DN7Rhpu2zsepuFxyfeN9as1JRUA60LJnByz0zK35kiiTg1Zn779Gzx1HC4tK85EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvt2FGpK7u06qe5LqV4RSywhF/4HAWqE6HniGltbJM0=;
 b=TSp14cUBY1TAeqMoksVRypG2tFOEVkxAyBJG/zH3IT+WC8Y/MmE+bVvIWg0NUIiOi6gTfFAUAg0VwCW6P0ai+a4kVvWkpwktDOwVt41vkwVOFHgqymfBUoprexDSuC64DhVifRj06e9L0x8tm4PcuCDiyMFDgHAMOlyd3aLQSc0=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by CY4PR21MB0696.namprd21.prod.outlook.com (2603:10b6:903:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5; Fri, 13 May
 2022 14:53:39 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%7]) with mapi id 15.20.5273.005; Fri, 13 May 2022
 14:53:39 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Shradha Gupta <shradhagupta@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] hv_balloon: Fix balloon_probe() and balloon_remove()
 error handling
Thread-Topic: [PATCH] hv_balloon: Fix balloon_probe() and balloon_remove()
 error handling
Thread-Index: AQHYZrMd2NPW0fE4SkuL/jrwHxzZeK0c5IIw
Date:   Fri, 13 May 2022 14:53:39 +0000
Message-ID: <PH0PR21MB3025E7F38EA2C9E951B5AD32D7CA9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220513102039.GA20318@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20220513102039.GA20318@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ef42cbc4-a32f-4781-bfc3-f498f1dc51e7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-13T14:51:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bff55708-1e15-4c57-80c0-08da34f05d9c
x-ms-traffictypediagnostic: CY4PR21MB0696:EE_
x-microsoft-antispam-prvs: <CY4PR21MB0696ED5A53E07772266B8E85D7CA9@CY4PR21MB0696.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dg6ZtxZZiVf6k5bIjWuLiS1UKADiZObjnsfRi/okfiTLaE0VE2XPrcDmoCaszvHbyJpfZjxu7lHDkoE2uMpXAw1A4608Es+BZauE9I7u5YSb5L/feZLi6W6mJ/cRh9tHV0Q/Nwj/NYfifZ0sZV8bfLkcOSIcmw7FjoCEopCdPvBgxRS3QBsLj8gEJqPZWwt+oK//uRb6pBhQPHoFpy/GRpaI20pnGqQJwVDALqEDBsN/WkTBUN6gbqm4JGjkV78FsaW4Nd9zn+ryVdR7gqJuMWLRLSlmu2mpSZRKOH5IQh3oT5mNL/vlGYP6MoixcgtqtJeVibsnA8Cgu1ISFgnyFSX/Qe5nR0RCugOC7NDMRzFtBrPiFhQUbkZtR+DXpP+e52oxTsQlUGh/Ys7kY2iMa0VB620rmU91TrHy6q5ODJChLHjDeRtISzmwAwwEURKb9haDbuZhx2/Fmd8rXiQy8XJwWbukueXoLHJmGaMlS4i7/KV1yNcQSRIUNj8X3mUyb1fSvYmTyCKHtRvzb7u8m1CPTWT1k6ptj0ZpepP7H4yzTjF97Do+qcfJOnVtsTTyNRxqjgkY0fSsdMUOZV5VXPn9l6oSoKK6q46sXfqBWi388cuZQ/JC2RVYX7J04FImutyYF8HDndYFZmuVAADRAev4SRETdUNzOcahA3toWD5n95v4dY7RUJnldn+S6j/KDoeDTABL60zMnVutiBUiu97KKLehGNZvOYblNRYELGAsqUMlCipucJjNXE8U3n5f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(64756008)(55016003)(83380400001)(86362001)(7696005)(122000001)(38100700002)(82960400001)(38070700005)(82950400001)(66476007)(66556008)(66446008)(110136005)(66946007)(8990500004)(8676002)(508600001)(71200400001)(33656002)(5660300002)(52536014)(450100002)(76116006)(8936002)(2906002)(316002)(10290500003)(9686003)(26005)(186003)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tswn85IwvSfXJApi7nOmenS+iX2Okm8ffuC5xTqYED0t7uQRCHbDZM14CA9s?=
 =?us-ascii?Q?fkTy20ovuBKSCRmazc4Qqh+sIUnM9LT8LWwRI0bYC3GWtoqhKcm6gn40oqtD?=
 =?us-ascii?Q?duuqjeLbt7F389G3Siw3o80PBluJ+0NooqkSWlDZbZGuKTf8gIa8v10Y1Waa?=
 =?us-ascii?Q?VkY53SH0vHXPXp9wRS96OPAszwrzKkuF8t0dVoLwlo8rkPGespHmQLymkapc?=
 =?us-ascii?Q?yfkW5J2qNes3vV8oHO8RSolnIZuwS/9xUCH0nb7omsabMoO2cZ75vLoMBHq0?=
 =?us-ascii?Q?lSeGM14gSRYSiG76ewWUdjcz37EYmL3LLYNj8Yd3LYRQ8lwn1/cMeTgfpOtL?=
 =?us-ascii?Q?7KiaSZsMejCc3gOU8UtXO0Czvuczii/KrEU0jWF/UXk+QAY57NNjYiNv90CI?=
 =?us-ascii?Q?F2uinOCt1kTy2YWVXbJxi1GsQRsPvznMT9O9xmWdaiRPztX7G80fV7YInQC3?=
 =?us-ascii?Q?Bf1J1g7D4eL092nLJR02reYvAwAfPZViMNWEzwuiPA2+rQn3B1eBHSbXu8sb?=
 =?us-ascii?Q?kLxHkEpOGFcKHmn9sZ3DRqws9x0VQepsIBboD+J8mRo3jwKHPgcaY2jM758p?=
 =?us-ascii?Q?p+5JcTLBaRiZDtx9GGqhxffnhQCCaJENS7BPvQtDAc1yOVkjf3pesCuIXSLk?=
 =?us-ascii?Q?uGY3deZpBp8d6qJRwG4JS8s6sAoQd2k3u8XhWgtCFZ5153dYhmKnoTo61vFX?=
 =?us-ascii?Q?CBZD0hErEQ4fsSTbEgWriRuJIOLE+kBVVcljxut2h1ZsWLDYtotkpvoAqF1j?=
 =?us-ascii?Q?8ly9SVDBBigcGRIq8h+wZVSxL4BZh+/+7uslh2ebUQr2rMh6/mucUUIglmeG?=
 =?us-ascii?Q?G9DoOgeJMMUm2Wj9T+zJR2kEjzphBFdT2MRATpu8KrXixixlncEXoIVlOgf3?=
 =?us-ascii?Q?Ap3nU0a1JMW7zbxJx/OJ89eU4iDWoHZZQ36iT6V5uNLTgqTPEdpG1A2U2ucp?=
 =?us-ascii?Q?wgauKLKl1AFzjF7MpDMaiXbyBSJd9ClbBn5XCHPPi1OzHdFJLbTqDcTbJ65o?=
 =?us-ascii?Q?8tMBWOYiTc7P26DTXMjz02dl9STMq0t6uWUJM3ums3mRd2q/esKcAKb4xgdo?=
 =?us-ascii?Q?5BQHURULJyGDmRd96uzqw1zvILdbZkUykzine7bnKQlEI+UuM2NDhUxOwAq2?=
 =?us-ascii?Q?R5J9LHnvnvx5Clxy8MHrH5olMeyGk7g0oPqYez0Bl4OSUfa8gmGtNUEF+vz8?=
 =?us-ascii?Q?2G4Bhc62Cxe7naP2v3o31YKWtTP59A5fdlcfNmtLJm1MzWlfUgu/5z95LtYp?=
 =?us-ascii?Q?aRjGBI3Zd1Es58Wor+VB16cTV+Rb9K1/RHnFGa1BZySXdsQpkDOcnviYcCrq?=
 =?us-ascii?Q?3dPqzH9FLYf5hwaDimYenap6JGwnlRmJZW57gzW2EF0un9NNsgPFYvzBmCx9?=
 =?us-ascii?Q?ElIpXZl/WqcZbnmxYu4cDLTnqGsRaxh0t0iTVyvzG6gD+XSSIxkUgiOVPR6Z?=
 =?us-ascii?Q?svukSRnQKAxwDW7EvlS1MnNmsuPn4+HE+lHtxuNtpqcoZh0Fxo7K/1J/eWIk?=
 =?us-ascii?Q?oL9LhfLA6Dcolglg5WwuC5qCQAdDNlLB9Wm/Ukd+d/k2ib8Wt9HA+a/DQ4ex?=
 =?us-ascii?Q?eZ9327h1VDMwhURQqVNvdUuPv7w8DSgT3uetE1SK9La9GrbsZ59c4oH0bl33?=
 =?us-ascii?Q?RKSeFx2a0AjY5nILkGYX+2rRpT8te+hMwCz1HUvAf6M6SLF1cNVclLYFYgD5?=
 =?us-ascii?Q?tmvPk8Ussr5IA7p5o6SfE+UI1dfZjeST9Aj10bcYNNrIg7net+fdeo5GhvN9?=
 =?us-ascii?Q?bQbNGdvXT7AYF4Wmj2KZd8DC6pqXD8k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff55708-1e15-4c57-80c0-08da34f05d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 14:53:39.3579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnpTivADX0ZmeglisTBQpPOdR9at9rUK+ORJGqCWUCC/tIhXuY5Bmezg3SdmYJ4CGL2NqEaZmd7OfifNpbYpb84QnW5nmOfiqVKMPe+24CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Shradha Gupta <shradhagupta@microsoft.com>
> Sent: Friday, May 13, 2022 3:21 AM
> To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org
> Subject: [PATCH] hv_balloon: Fix balloon_probe() and balloon_remove() err=
or handling
>=20
> <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
> Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
>=20
> Add missing cleanup in balloon_probe() if the call to
> balloon_connect_vsp() fails.  Also correctly handle cleanup in
> balloon_remove() when dm_state is DM_INIT_ERROR because
> balloon_resume() failed.
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20

I think these changes look good now, but there are some
formatting and process problems with this patch email.  Let me
get with you offline on the details.

Michael


> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index eee7402cfc02..98fcfb516bbc 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1842,7 +1842,7 @@ static int balloon_probe(struct hv_device *dev,
>=20
>  	ret =3D balloon_connect_vsp(dev);
>  	if (ret !=3D 0)
> -		return ret;
> +		goto connect_error;
>=20
>  	enable_page_reporting();
>  	dm_device.state =3D DM_INITIALIZED;
> @@ -1861,6 +1861,7 @@ static int balloon_probe(struct hv_device *dev,
>  	dm_device.thread  =3D NULL;
>  	disable_page_reporting();
>  	vmbus_close(dev->channel);
> +connect_error:
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
>  	restore_online_page_callback(&hv_online_page);
> @@ -1882,12 +1883,21 @@ static int balloon_remove(struct hv_device *dev)
>  	cancel_work_sync(&dm->ha_wrk.wrk);
>=20
>  	kthread_stop(dm->thread);
> -	disable_page_reporting();
> -	vmbus_close(dev->channel);
> +
> +	/*
> +	 * This is to handle the case when balloon_resume()
> +	 * call has failed and some cleanup has been done as
> +	 * a part of the error handling.
> +	 */
> +	if (dm_device.state !=3D DM_INIT_ERROR) {
> +		disable_page_reporting();
> +		vmbus_close(dev->channel);
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -	unregister_memory_notifier(&hv_memory_nb);
> -	restore_online_page_callback(&hv_online_page);
> +		unregister_memory_notifier(&hv_memory_nb);
> +		restore_online_page_callback(&hv_online_page);
>  #endif
> +	}
> +
>  	spin_lock_irqsave(&dm_device.ha_lock, flags);
>  	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
>  		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
> @@ -1948,6 +1958,7 @@ static int balloon_resume(struct hv_device *dev)
>  	vmbus_close(dev->channel);
>  out:
>  	dm_device.state =3D DM_INIT_ERROR;
> +	disable_page_reporting();
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	unregister_memory_notifier(&hv_memory_nb);
>  	restore_online_page_callback(&hv_online_page);
> --
> 2.17.1

