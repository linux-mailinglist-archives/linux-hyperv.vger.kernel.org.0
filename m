Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EDD51E812
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 May 2022 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446593AbiEGPRS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 7 May 2022 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446592AbiEGPRO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 May 2022 11:17:14 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021017.outbound.protection.outlook.com [52.101.62.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3FC2D1FD;
        Sat,  7 May 2022 08:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVSkkcGbrgTf4QpcqbR9x6oF7rtWaf4M3t/uSf1DKPRF/Fm1kFQ9hRncEM1o3sV5omt837u33uhg7g1kiE9GXsSG3GX3mseqz4L5WbqlRniobpiyvPp76FRAqmMatr9C/BCRQc3iF+IpdrVrdfohfokPiPNLFXENq3HQ/cWaCrcbJMWse6+JjZfmXiC1NSWuMsQ/9Xv1OJNdwtqzhR3CMapQkBA+4rPEMMG/wnqIsLLZdQgAqHuST9gMtzi9+hzE+WZggHD7IS3J+JAlXmISDgVhptggyaHIhuR33/HxL2gm7PLWTEXRJl4kkipmoHlL8JkWlSkFoEVEYXXSxx5hsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2+yf/0qMV+3VolXZJKdupKHHLKWPSGlE7Qbkm17iq8=;
 b=ka7V7gX0Wpk8Y+xhVQuLhhpZI1I5JGQHoiAiQaZemIYPzA6sAEbz/w9QzGEib77WCfcYMqErNhPMgtkYbohmJEdqBQEmwv653wNXWEMizZBWGqtkEL85QgYYNPB8DGUfGVf98LTBTmpcguAbaXyJoMke0aT8WqgZ0xzC9NQDhYTMD9DnnI7KYXK4oyFlnemaC4/f9kRLDTffabs8pVgWcHQejr+bo9jcEbHbG6Qb0ib9uh13R1S1Gm1Hfz8Qhcjx/8Bt7V+sEx7FEV3tUhml9zp/D49nqym+vP3qz+i6ZqdskoDv+ppkmHXIFS3qO1CWHdTHdQAfShqp5y5KUOttTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2+yf/0qMV+3VolXZJKdupKHHLKWPSGlE7Qbkm17iq8=;
 b=UbeI+gcss+mB/FnwrXslyD7ORqAyY8fVrS9+T08xGpsPxq7aF/hxdaLboW4/xanp0VxSYxPzEC1XSlgWkWRaSfc1cmPzcJ/5LYLnU3erasvXRPUgJjjvZezHObDpfWpND9AS+5v3Wh3bTFjGHhG0f7CZrNBSOm58XCvB9Kj+vgc=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BL1PR21MB3355.namprd21.prod.outlook.com (2603:10b6:208:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.11; Sat, 7 May
 2022 15:13:25 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%7]) with mapi id 15.20.5273.003; Sat, 7 May 2022
 15:13:25 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Shradha Gupta <shradhagupta@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv: hv_balloon: Fixed an issue in the earor handling code
 if probe failed
Thread-Topic: [PATCH] hv: hv_balloon: Fixed an issue in the earor handling
 code if probe failed
Thread-Index: AQHYW6yhjP3rzhGGekOq2Q4DOOtaJK0Tf8qg
Date:   Sat, 7 May 2022 15:13:24 +0000
Message-ID: <PH0PR21MB3025EB93E33F29C913CA4193D7C49@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220429093635.GA4945@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20220429093635.GA4945@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e77974a-034e-406a-9052-3104d94ba396;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-07T14:05:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e972b6b8-6138-4beb-89c7-08da303c21b7
x-ms-traffictypediagnostic: BL1PR21MB3355:EE_
x-microsoft-antispam-prvs: <BL1PR21MB3355D6B916121C25F4AC9FF7D7C49@BL1PR21MB3355.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ye0+BZMt/FB0+E9rQmitVWYz1L8wuRB6unMeJzz9pj7PvR16UTSFW39WD2lQt2ETScSEsf8HaoTvTvtPhi3+ym9Ao67gOqHLS5P68qnDVUBSQvWoKYcx7V8+d9oj2ntJMDPMu/XKKUveNk9ZL2kzZ0tpQbYPJb2qm1vQ/q0OlOKDeDu0btpht5hJyJHF3CIqiTD++zfxK7wA7bIS87BSQHH6Qbm1hzX1CsHhhaTPdRLI7qWFcFCv1wUuctdkWs54qiy3k6RbCj2jfYCAxcqg6E6q1BBHDeaAmQzrP3K9IhU4bSU/RJNKlXMEHRSuHrHFqlahYM6BNE1EyGjzDy/QG2f9GhAcPtvT+6SzNPYOiiON5YWhIMZRLnWVJoBlCFdY3M69Br3RqGPJynXiT77TzKKoi+06WE6lnakILOooRoVs8V8S76UypZMM7MIPxv6FpD0EXnL2Ut+ptQ/Z/S3+QOmASwylGUjsZfdZZiJLdafICTGApqE4uURRnSdJAniH4zDnEgHHWigF63rRhIIiK8G1Wz0LYwu5WYjVbcMov56/l+bsUsIdI1JWC9Rk2Bzrfcpov14ND3yBam+tABmmCtGRMTHfpPWVi4746U6ARG93jHczAOBZieba6gXE/qlnsbLi4Eafn8d4iPzEA5fA293Rd4aX3d22NUOkq658aDg3QHSJLReL1fNrKB2HdVJubSZViItlbFaF7u74qet4A6zbSkynIIoyocPfeMGNCsYgORQhB74N+JI3dK3Dn/Wb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(26005)(122000001)(82960400001)(6506007)(9686003)(82950400001)(8936002)(2906002)(55016003)(33656002)(52536014)(8990500004)(5660300002)(10290500003)(508600001)(316002)(110136005)(64756008)(66446008)(71200400001)(38070700005)(38100700002)(8676002)(66476007)(186003)(86362001)(66556008)(66946007)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K/70jXQeDl3OUKrnctAryp5bW5vJpOTxWyX5Tzq6v8tcz2WPSHCcd7x2jB3q?=
 =?us-ascii?Q?h0rIZIbePhnoK6sewhIFBQ5XyDwIXJXHTuLEaqeLf7d7CI3vRwBnVWANXXYb?=
 =?us-ascii?Q?ZWiv7yM6A5zgF4eZ/sixhWomxkXUB/gXWR0Lypm2/mV+b5S+B7tKlBjbC99P?=
 =?us-ascii?Q?5yl+eCyF0CUjqqJ7pYqgjk15KJFC7zxZVqhl5LphAvmNmuyXOKGHJ/JmS8jh?=
 =?us-ascii?Q?EIKGnC3PBIa1lyNIF7OECEqYgql3FTGgFKvUXYHQURevbPP2Kl/+3iZM2pEI?=
 =?us-ascii?Q?tvPSAD3AGcU9rps0dzHBDwh7hguzkl/cIeyRzCM1CNzQgEeI6Xz1O3/h1XtI?=
 =?us-ascii?Q?QjdoxVohRag1ZgejgGDZ5OgqZQJ29T4EP/Pq7Ty8N3Ch6XLKuUo3MIzoEG39?=
 =?us-ascii?Q?QPNdLlaHLL9wr81kiP7TOglXREvK2HKEun9IfQd9LHxjA+tn/m+ivQltV21Z?=
 =?us-ascii?Q?lh6VHjy3TBVGTFL13yJKEdPYPT4AsA654GDS43grtlKqq8bmT9N95sqqco6U?=
 =?us-ascii?Q?bEbCAa8z6L1Q0iJAibLbn3h603NVBJKtx1nDP9Bl5of/jSAv39un7Mo862rO?=
 =?us-ascii?Q?E1ti5ghnLDpeBRc6lNO8WLdWzOB6dd/wL2f9IILe2kng1xqzJq3V3sa9kEgS?=
 =?us-ascii?Q?ofy2HzTv6KhkSGW/xkqIvB1VLnP9J43NK7Gqr2TR3RMCSPosCnunleQ12ydT?=
 =?us-ascii?Q?8EE3rPrhuoyfIvyJI6tICzbKqMuPosPLafSIStoCkBoWBqO8sGncYHBj+57C?=
 =?us-ascii?Q?BxDDcFGGxT7fXqYtzmYG+lM2NIQSx+v/PEVGHg0Zwo8k/1iDaj1AZ0T4Lrls?=
 =?us-ascii?Q?R9X/R8Z9RaV+P8oSLPTL+D0TCGRYwDYWUbxyLGemeOEZ1uzlg/npZncUM9jD?=
 =?us-ascii?Q?JXYK3oU3UI94ZAMgAkBjhG+9vy9pX86G17u5tbPSDnCuvQ+UqRJxb/yNxai8?=
 =?us-ascii?Q?QmBwfzwK5axaMAYDpdpyUGzapK60eEA6UXMtZ7ayvX4Z0kF8L36G4dS254ur?=
 =?us-ascii?Q?nzwXL7qJS60CIrWvvuaPA/XGqBI7YwzlQ5XWjKWdG09Q1GX59eqN14tj6kXL?=
 =?us-ascii?Q?hU4+Y6BlTm4Ts4zLufnCaVvbQTVLPYhPc/RGYz/u8FLidg7YSMQIVmTTOqaG?=
 =?us-ascii?Q?42CUldQL29TkMgxaCRmcerAkIBNh1nNbX5Cxm2zxJ6+S+oMrpiaBAi9/kMVn?=
 =?us-ascii?Q?5464krrr4dc9nb+RhlEhkxK9fJEOH3qokm1CJuFGjwMxe0oPqDJlG0tQ5PBT?=
 =?us-ascii?Q?onASO8VsmiIZtWq2H2cPBzQ1kouJklrqa++s/axn5UZlKmcFpH4jRuUI0RCS?=
 =?us-ascii?Q?4NXl2uzC3Axhn9IIB+2IQLRvG7yDmPI82PXdlHAZp19GiAP2ERm5DGNP6Nzt?=
 =?us-ascii?Q?Un55cUMobREBWFyIsKV6/5US6G2QVlKXU2P/NYmgwTVMhIShNtw7v0nihOzW?=
 =?us-ascii?Q?XPa9sc7Y9Hdo9WTm/G3TtruGdgQytd5yHiZ4q90CJimKWjrqyhlmExTRcFJj?=
 =?us-ascii?Q?uhJ8K44HQvNonynuftMk9+bEdAeAGCImK1EFph3VdjuXFsaeyVZK+9LW84a0?=
 =?us-ascii?Q?+yWxKD10SKK626wxEEbzfqiRKaUC0Z9BK2SHKRjx6egDiQXzPK8bjKZ+Dowo?=
 =?us-ascii?Q?DhGvLuWd2vz0I/wV1bKch7vNC4Y1WhOBiWq+QvtlsNRDwmlDPJPk9jbkHqrI?=
 =?us-ascii?Q?pco/WeGODvP6YWU+a1VdliV3J46P49eyp+LsdG2vpn2cyLEh8St109ZvdnJT?=
 =?us-ascii?Q?CDXtGLiNPzIpZR2xxYGXzLan2ELpfOk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e972b6b8-6138-4beb-89c7-08da303c21b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 15:13:24.7643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1D+Rw+sF3iTZeXl0tz1iRL+OpEgcSps59jKqmBmhaCPNjB22RE9lWAsRn+Fi5kUoDCT9Le/RYfYbKBa5PeUd8Be/6+Ayx/LefcVQoeAYUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3355
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Shradha Gupta <shradhagupta@microsoft.com>
> Subject: [PATCH] hv: hv_balloon: Fixed an issue in the earor handling cod=
e if probe failed

Typo in the "Subject" line --  'earor' should be 'error'.   Also the prefix
to use has varied historically, but is either "hv_balloon:" or the full
"Drivers: hv: balloon:".   Use one of those two prefixes rather than
creating yet another variant.

And let me suggest simpler wording.  For example:

hv_balloon: Fix balloon_probe() and balloon_remove() error handling

>=20
> If the balloon_probe() function fails, we do some cleanup and similar
> functions are called again when after this a balloon_remove()
> call is made. This fix makes sure that the cleanup is not called
> twice. Also made sure if dm_state is DM_INIT_ERROR, the clean up is
> already done properly.

I don't think this commit message is quite correct.  There is indeed
some missing cleanup in balloon_probe() if balloon_connect_vsp() fails.
But if balloon_probe() fails, balloon_remove() will never be called, so
there's no duplicate cleanup in that scenario.

But if balloon_resume() fails, then balloon_remove() could be
called at some point and mistakenly do duplicate cleanup.  That's
how balloon_remove() could be called with dm_state set to
DM_INIT_ERROR.=20

Also commit messages should generally not use language like "this
patch" or "this fix".  Just state the change in the imperative
voice.

I would suggest wording such as the following:

Add missing cleanup in balloon_probe() if the call to
balloon_connect_vsp() fails.  Also correctly handle cleanup in
balloon_remove() when dm_state is DM_INIT_ERROR because
balloon_resume() failed.

>=20
> Signed-off-by: Shradha Gupta <shradhagupta@microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index eee7402cfc02..7c62c1c3ffc7 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1841,8 +1841,13 @@ static int balloon_probe(struct hv_device *dev,
>  	hv_set_drvdata(dev, &dm_device);
>=20
>  	ret =3D balloon_connect_vsp(dev);
> -	if (ret !=3D 0)
> +	if (ret !=3D 0) {
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +		unregister_memory_notifier(&hv_memory_nb);
> +		restore_online_page_callback(&hv_online_page);
> +#endif
>  		return ret;
> +	}

Rather than coding the cleanup steps directly under the "if"
statement, I would suggest using "goto connect_error", and adding
a "connect_error" label immediately after the vmbus_close() in
the "probe_error" sequence.  This approach avoids some
duplicate code.

>=20
>  	enable_page_reporting();
>  	dm_device.state =3D DM_INITIALIZED;
> @@ -1882,12 +1887,14 @@ static int balloon_remove(struct hv_device *dev)
>  	cancel_work_sync(&dm->ha_wrk.wrk);
>=20
>  	kthread_stop(dm->thread);
> -	disable_page_reporting();
> -	vmbus_close(dev->channel);
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

This case where dm_device.state !=3D DM_INIT_ERROR can only
occur when balloon_resume() fails.   Looking at balloon_resume(),
its error handling code has already done the cleanup except for
disable_page_reporting().   A call to disable_page_reporting()
needs to be done somewhere for this case, and for consistency
balloon_resume() is probably the best place.

I would also suggest adding a comment just above the new "if"
statement you've added, indicating that the case being handled
is when balloon_resume() fails.  Again, balloon_remove() won't
be called if balloon_probe() fails, so it is a little bit surprising
to end up in balloon_remove() with the state being DM_INIT_ERROR.

Michael

>  	spin_lock_irqsave(&dm_device.ha_lock, flags);
>  	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
>  		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
> --
> 2.17.1
>=20

