Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66C4F1CBE
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Apr 2022 23:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380176AbiDDV2m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 4 Apr 2022 17:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379399AbiDDREa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 4 Apr 2022 13:04:30 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E3640A22;
        Mon,  4 Apr 2022 10:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as8eekxYet7k/OU5m7LBQ8bfeGKOWa6atKzUqIs8UFTjpAtQvRlF0t0kEb9U80V0vqs+jJkf8TKIZvEEsC08Fh6uSCLRbH3lTT0uzAoaYdpSkBUAh8PpzpDRNUHfSlaqUTFatp/3uduX4edbpeu2shYUcpnaUenkXX0QkQ5ubNj6gsHD2XgYchFknWF4BrZ64M5aQ4JyWFZ0keleFKb9vPzij73vMVUxg2YpGeEk1D35JfOy3X3hlKuJ6gIAIWPqEtI/zyCMbOZvgqtYE0+QLvJp9yHDmApY4oM0iRT41wi26SaZ+Vny6KCI1dqhChpOFh+QECL+XT+QdhHXSu/3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t6NCciWH3iLieavvJjHOHbTQzDwg/H46l4Lh5q/62U=;
 b=QlAslsbV1ytf9UlQTLMsWwOuKPx3F+ns4xSUiulcIc7KzR0C28IyES564wUQ7RPDz6/Xg5yT0gZBORTijI4IA5lpvqyOQ5wIRBbmz3JI8xoyM8WEIdx1iKUMLDK+NuXcFrgaREyiqN7ek3A5d55Qw73j1yPD5aVR1V9niCx7ArOOVdG01Lj0VXrJSfsILfqNrJLRsLgGQsdKwfOahtqs2yhOHk89LiJLMRj6yVXG6KUvbI/o8JH63t/fEYo/IHGnp0J1DDvGyM9qbzfkr4WVX6sUu6DS0o01dF4eLfnsQ+4rDbhTArzdgMvPJxCKOSN8szFhGNkbO4Xxt44PcPHFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t6NCciWH3iLieavvJjHOHbTQzDwg/H46l4Lh5q/62U=;
 b=FK6pzmxDP+JxHM140i0I3T2EjY1L/nv4e+7arz+3xo+ZYT0V5Uw7tAiQ1B2+tOH27D8ooWI8250JyCW90ERC94LJhJ8OZJoN1+hl59xOLKb8nGBkzcrI8zNs2nhIF5AdBYxys1DSgjCdnxGdycbv5e/jdaVvu3/eMQB0WIondJw=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SA0PR21MB1881.namprd21.prod.outlook.com (2603:10b6:806:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.2; Mon, 4 Apr
 2022 17:02:29 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22%5]) with mapi id 15.20.5144.011; Mon, 4 Apr 2022
 17:02:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Thread-Topic: [PATCH v2 2/2] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Thread-Index: AQHYP/CrxDvs+5wBAE6aSH6mCNoVmazgC21w
Date:   Mon, 4 Apr 2022 17:02:29 +0000
Message-ID: <PH0PR21MB30254F9E39AF333E78E1721BD7E59@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220325023212.1570049-1-boqun.feng@gmail.com>
 <20220325023212.1570049-3-boqun.feng@gmail.com>
In-Reply-To: <20220325023212.1570049-3-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c25532fb-36b4-45ff-8834-6267264c2114;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-04T17:01:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba1b1ff4-97ab-4363-be0e-08da165ce735
x-ms-traffictypediagnostic: SA0PR21MB1881:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SA0PR21MB1881D6A5B17B8EBACE7324FCD7E59@SA0PR21MB1881.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iCW+Vn4tZ54sdVdTGKcb3/PzDqh8WikfiPdEYUaLq6rIbrC3Hb7yeeskOCnqosv7QAKGhnrwaJZbqGsU7DqoL7tmBhOYeI/6kGREafS3MTu3Gd13/ZcuGLaGTgEukEsgM+kJRdttdncGV/iEm7pl6KBnaLxD8AQPum4ot+Kd4PkKt633R0fQ7UPKgfLR19fL75GbN26r7G0e1f5KvgfqMaVUjDP9uiybRsJ+NU54dXodakZNgqucwlu7vKprfb3oI56K7NzlnVM0TPhr9eOy95b85qDnxpePvTKTCYRkm6LwGuHO+YqL4x4c2xImXYKwl1S7/MPuK3SfyyIQmay/7jWoG6N5znOhaoFcxNqyjxEHlqr5BmM3jE3SCIwdeClOE363CrzB3cQe7DChFjj7TgzDo1qZ8lcLixsVVKiKS0jFLaYUwoRrkC11Qx59K1tDZjW8wPpT3RkB/fLJBvgbf628Ga43OforlO4m+9BD98eUtgoQShZlEBIGCzkhsA5/Kb14BsXCQOA07aoEAIzu5Ur9fWb0WiHznWacfoZJwu5ucpYSRUhXrOKNpzkspGefwXmAwkTrFm8nJckFLZ+XIH/Fi5nHsqEivaIwgYHIm9Qhv2sNDUSRMcv03gVn0Ro3soR8f0l0lNyJHflslu0fQX8FV+tuFcBbjAujhePvYPfIim8WEjpEj7Kt3S4xkOhX5hAQj7jrazMe02n7XafdGX+lpLhgO+pcmu777hx8kaUuXtmlFwF+aY3xvdu52BGI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(8936002)(5660300002)(9686003)(66446008)(52536014)(82960400001)(82950400001)(64756008)(66946007)(508600001)(122000001)(33656002)(76116006)(71200400001)(4326008)(66476007)(8676002)(66556008)(316002)(38100700002)(10290500003)(54906003)(7696005)(86362001)(55016003)(38070700005)(186003)(26005)(6506007)(83380400001)(2906002)(8990500004)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L8mLupbuycDlIU1f5aZwIgHzsLWhExp2rXPl7L9r4+Iwa7IbIGeCkAIl/x3t?=
 =?us-ascii?Q?6OROtCqbuwEN+1yAlwVV6PRTCHYPvAPnYcdNe2WFB1xVFtQ7K0oz2xh9S5B9?=
 =?us-ascii?Q?4TFx5iOkDG/rVQFnyhCDD2108ofX9FhvrnpjvJmZ71vaGUISYv5mqK/dj0HD?=
 =?us-ascii?Q?fF/AOavL8Az+aGllvU9gp1C1ao/Vuaf7Ouo/ishkvNJnCWELOrcU/ie8RCsg?=
 =?us-ascii?Q?c1yngEoLK6Za5KGD1P/4KCtu7Cr0xxDV1Yoy6E2MKOM3UZqKI5mSV+LPQtKR?=
 =?us-ascii?Q?uzk2hDBkr+ZirONo/Sig52vCw8yaE/O6kCTTnMHSnGCtirtryiS4+jienbMY?=
 =?us-ascii?Q?X7sbCagocl/BJ43ns84Z+rmS4L+vE9NkYHLKUxEetRj4orka6aBUTHzQ44/l?=
 =?us-ascii?Q?SOllJ3gO2Jw2jpgDgbS9jk12pLVtlSQ+6ni6y4eoaNs/lhnRy8lfLJCHaFrS?=
 =?us-ascii?Q?3Ma0eOTFOPaWMpE/c73x5GSWIbMe6wDW4Cf028szVyjz9sOjKUDGSq6uiWPO?=
 =?us-ascii?Q?3bsquKWbsRYt77k0msOnZUW/naMOy4MkunndQmOW76cHI+x0eY86at9mGtyW?=
 =?us-ascii?Q?+EhnKk1RoK+MCivupCVqhBvSMK7cV+gCrPxmjamZozmln5kx6IAn5L+XEdny?=
 =?us-ascii?Q?ITciPfziOvJCkHWe9gR4k4mpDozbWjCCQM8+pa71BLlTppit5OGAOe+nmFMh?=
 =?us-ascii?Q?oX9jE0az9fq+331uy/lpwzXcy918aEW6pniLeSLcQlbIHrMNNITdEcqqcyjF?=
 =?us-ascii?Q?8yEXS5G84kZbArAtqS4t3UpbQPlUNIjIjv0NdUv2d4KeyDqNrBiyE1pwtvYs?=
 =?us-ascii?Q?DnzKxCDK2oY4J+VSgrrOsJvVnH6IXT3uN2HGYFroopVoneC8O5OgkCH7f/S5?=
 =?us-ascii?Q?2WHgUl+DSE26s9IEJD8elSksY2v5nYpIRoH7jvciwrVNaE/87qRsfoir4Jqt?=
 =?us-ascii?Q?Oyi9XiOipKUZ+dcGFtDC+zeiFtcjqPzwS42CFqNZBl3syuVQyHUYrqLIhKcu?=
 =?us-ascii?Q?m5PweAYj93a17GJdZ3SyiYt125VpWLZxPTJ0zL5e3/UvmDVHOGk/IoCEh0lI?=
 =?us-ascii?Q?RyMTBYOb0zHJwJes5dxAXy9JXAUwsqCcTReGQ8faLYHpT/4M4A95e5sdHueD?=
 =?us-ascii?Q?PEuzODlNrYCfl818rpIEBFkfNLcfN1Lic0QaNXGYssYhnZoCsoTROJl2ojQD?=
 =?us-ascii?Q?+QxT96rWRCcwlu0NDdTIvBuOr02OiAPvHsrtaelp2YmwVdf9G0dRyYxqXWmK?=
 =?us-ascii?Q?aYsx+z4b4R+9tLcCu3eqbgzVrCnIUtWf7H5XVlktbs5hIBqzzKZoY07Vp0s2?=
 =?us-ascii?Q?Lthp0D8si78WEbsTYYOk1kr2TLDH21jO+evhDAB3TFp+kniaKDq1dOJP0l2p?=
 =?us-ascii?Q?EeZe62fjFwSQBYINRZRFLEUCuoJebwoTBzsTrHTRqHZkmei8f8kBK48QMlyP?=
 =?us-ascii?Q?nB6XSKUgdLwO+wWbup9/9P+WH99gvuo7Nfx4I+SZnhe2kL3beowbYnpcR0/D?=
 =?us-ascii?Q?wpUymXjWG9P7qc7/Cf3zPYjHZ4kqiCPrsnUknghAO8D/cY7nF6s+oqjwTB4P?=
 =?us-ascii?Q?2NwK3hDnphvd/N+kQ5GnuV9DqnuLVdrYe5yIWuQg0Dw0B+60emkL2cEsrXIY?=
 =?us-ascii?Q?Dt0G38rxFjjqNKG0N1FN5gDltsTRO+MTIs5aPcyVPyYEpafyBwWWJXF1GwO+?=
 =?us-ascii?Q?msLRLVLut5Faf55iTjdm692q0BAso7KdGQkFve+kk0MUpRQChq1XqSLTlLV1?=
 =?us-ascii?Q?dcGl63XQXhmGRH4onu9K1ijxTeZY6GI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1b1ff4-97ab-4363-be0e-08da165ce735
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 17:02:29.5457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvtG8+DAxeLGyDHNYrQ/jCIyKF13VJ0yU0ufD7S95wV7FdrTsG9RPWy83pr6MzIwYyKcahS+TIlcR+5mcuDVrJZL4ZP4Mm4CHQ653jN8j/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1881
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Thursday, March 24, 2022 7:32=
 PM
>=20
> Currently there are known potential issues for balloon and hot-add on
> ARM64:
>=20
> *	Unballoon requests from Hyper-V should only unballoon ranges
> 	that are guest page size aligned, otherwise guests cannot handle
> 	because it's impossible to partially free a page. This is a
> 	problem when guest page size > 4096 bytes.
>=20
> *	Memory hot-add requests from Hyper-V should provide the NUMA
> 	node id of the added ranges or ARM64 should have a functional
> 	memory_add_physaddr_to_nid(), otherwise the node id is missing
> 	for add_memory().
>=20
> These issues require discussions on design and implementation. In the
> meanwhile, post_status() is working and essential to guest monitoring.
> Therefore instead of disabling the entire hv_balloon driver, the
> ballooning (when page size > 4096 bytes) and hot-add are disabled
> accordingly for now. Once the issues are fixed, they can be re-enable in
> these cases.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  drivers/hv/hv_balloon.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 062156b88a87..eee7402cfc02 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1660,6 +1660,38 @@ static void disable_page_reporting(void)
>  	}
>  }
>=20
> +static int ballooning_enabled(void)
> +{
> +	/*
> +	 * Disable ballooning if the page size is not 4k (HV_HYP_PAGE_SIZE),
> +	 * since currently it's unclear to us whether an unballoon request can
> +	 * make sure all page ranges are guest page size aligned.
> +	 */
> +	if (PAGE_SIZE !=3D HV_HYP_PAGE_SIZE) {
> +		pr_info("Ballooning disabled because page size is not 4096 bytes\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int hot_add_enabled(void)
> +{
> +	/*
> +	 * Disable hot add on ARM64, because we currently rely on
> +	 * memory_add_physaddr_to_nid() to get a node id of a hot add range,
> +	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
> +	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information for
> +	 * add_memory().
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM64)) {
> +		pr_info("Memory hot add disabled on ARM64\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  static int balloon_connect_vsp(struct hv_device *dev)
>  {
>  	struct dm_version_request version_req;
> @@ -1731,8 +1763,8 @@ static int balloon_connect_vsp(struct hv_device *de=
v)
>  	 * currently still requires the bits to be set, so we have to add code
>  	 * to fail the host's hot-add and balloon up/down requests, if any.
>  	 */
> -	cap_msg.caps.cap_bits.balloon =3D 1;
> -	cap_msg.caps.cap_bits.hot_add =3D 1;
> +	cap_msg.caps.cap_bits.balloon =3D ballooning_enabled();
> +	cap_msg.caps.cap_bits.hot_add =3D hot_add_enabled();
>=20
>  	/*
>  	 * Specify our alignment requirements as it relates
> --
> 2.35.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
