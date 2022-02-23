Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EAD4C1923
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbiBWQ4A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 11:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiBWQz7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 11:55:59 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021027.outbound.protection.outlook.com [52.101.62.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667691CC;
        Wed, 23 Feb 2022 08:55:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPomTlQgzdnPugdhBCNrncsEgQlQli87BllLb4AzejlzBMWVSkEXsANSZzjypITyIsMGhPc64M7D39wDqh+XgsBNXVjlS9S7D71lf75pX2Mex6NdWCKyNVP90J+brSuQ1uLFjO+E4MtPqZgWAIzSl8JkGGZRJfuNhTcZtpONKMyx/m4IRntlFjA4aIRSoBq4HQsUex7ZR/EnvWcXQSoS+WH9oQpNZdxh639KWpFVZ+8KD+fnJqiQs9vHF0yiXK+/lzIcX8oSqmNsGFVYaxhil8/SR8iKn8phAIONCCAltXKBu23C99HiaUTa6IELj9rYPFxs8m82zkx8T9d2sGI2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjpx/1xA+G2noI5jDuVxwZte0A75njqgQi6kGqgH2k8=;
 b=IDL3MZJQhF9WztEcvvlXfZb5GEV96kRxD4dIT6TZE6KdcK4apa9J8uw7DC2zatnwFqQtLy4yuH9IMMBinfRocGOCaGDFcL1LjT46ghscC89L1jS0W9pwBcjOA0c/+WL+pUbxSFV9xcCTrKhif8mBcpt/aART49UJP5U/ZDMDUbJ3K4X0tQwXbEJl60rewZ4v54W5w+OObiD50rTGCiA1R5UPU/i66mzGrjunG8THhq9f8JS4jTcqWmD9LbCPwJVyuTVhqGJ/WI70iRgL8yJtNvh+eltypiRuS+GJQAr/LWIzXaSfpYRvJXHyR4ZxpMNjKUnB+yBnijKFaLrYCdiDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjpx/1xA+G2noI5jDuVxwZte0A75njqgQi6kGqgH2k8=;
 b=hSi8MIm/h91pTVfrXINP8ZfDp/yyFPMQgiOvv28eDxUhpnTZ7tJwLHYOUc72BJHnXP+1ZCcfRQB2zD7TYG0nvUzfd5Hl54ok7RtDbRR/vE/D3dl9RKc7F7fX4Nimjk/zf7ylJRE2fjhUPke461iLOKsBAr3XZaMqKh17rwJj5PE=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by PH7PR21MB3358.namprd21.prod.outlook.com (2603:10b6:510:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.20; Wed, 23 Feb
 2022 16:55:25 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c%5]) with mapi id 15.20.5038.006; Wed, 23 Feb 2022
 16:55:25 +0000
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
Subject: RE: [RFC 2/2] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Thread-Topic: [RFC 2/2] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Thread-Index: AQHYKLeM3sCLI+VUq0Sl7YfuaLrf0ayhWD6A
Date:   Wed, 23 Feb 2022 16:55:25 +0000
Message-ID: <MN0PR21MB30985DC877AB58DD1A849900D73C9@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <20220223131548.2234326-1-boqun.feng@gmail.com>
 <20220223131548.2234326-3-boqun.feng@gmail.com>
In-Reply-To: <20220223131548.2234326-3-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8208dc4c-229d-4a63-8288-cc9108c7a735;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-23T16:46:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78fedf70-3c44-47b4-7ba3-08d9f6ed499b
x-ms-traffictypediagnostic: PH7PR21MB3358:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH7PR21MB33584E2211AB52BC2EC50EE1D73C9@PH7PR21MB3358.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2p5NlEaj9NIrCcIJQLUzD8A2n4tzmZTdYqpRfOBTyiJ/spXIYL78dF24T6Cowew1PPaOSD1YO/YDJWLZ0us8ebNdOcz0j1UIbbBN2BJBiEFEMCVWkrRKx/rWoxhu7mrFanN0kWidRotUL63T9LO1B7XRNz25WwzSYXiCUawbpRcPsj5Z6E+JtYqgJ4+eLuBb+KLQMycZKXqTNTniwQKzsfwWfIsd/F+olot89ePdt0D74AV+LSgcPTs1j/tPGpH4AEKzrBT4Xjit35OT075JlHgYCTLZRLtls8xgHlTRRFpqAFW9KxZ0jy/SVA/K7Hk9Wryg0kzBhI+koRHSEfbAAnSUuLCW4jBbBrWZVeHPP7V7JWLAT+6AZKFw52eTxBkYb589ulTD83LRCP9dKWvro4rglJuoR4Ti4h3tOHi4dMPTep+ZommIVlkpQphCQtxWPy9zlScD7VkH4UXXeiLzt+Km32R2mPkuKf+pwa/+75rW2z7bqAPLxABwFOrtnPADUZaNLRIjQoaqRXqbhmFAL74qJRu+rnug36eySidPr+EfffoN/wYSLd+gHSxdtTeEMPO+45ZPBeQflrw1MSsGJKgzbpzX4sWwP0lakKAS7DmEW1oLx683HSSVeGRDnT3KO/Q/4ffMVElF9Beh0ovjfTPSVZ2DVb37zQAMekGzyWrLI8C1JPU8AlLSfb97Fh1ol0vs86P8raQriqtA0gSaqIxMtW3AYUjPZ+lI6AJshbtiLLuWzRbKNZzVCMteHbTf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(52536014)(8936002)(26005)(8676002)(5660300002)(71200400001)(7696005)(508600001)(6506007)(9686003)(2906002)(83380400001)(10290500003)(55016003)(82950400001)(82960400001)(122000001)(38070700005)(86362001)(33656002)(66446008)(66476007)(110136005)(66946007)(54906003)(66556008)(8990500004)(316002)(38100700002)(64756008)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d6WGXRhVapm6nDFlFlyjXq1ymbbyVFbhQ5EWivqa0Zj492ev4613KSZ+5Pno?=
 =?us-ascii?Q?qiTofZwarO802/vap6jAZsocjGxt6p66xnhSofi4+WABDS+dQ3xRuNZfhAMy?=
 =?us-ascii?Q?TwibesoWeQB8YubUyjP9Cy8/slJHHsX8upz2IN6kyKyGgp4g0OVfaiX4jHRU?=
 =?us-ascii?Q?/C13+3jliPK8vhZWnWrE6DNx2y5tiHTFRbmvIN7JKAAtmQZtE5dvC2o6+M0l?=
 =?us-ascii?Q?9cyKFpXYornlUKfYMNlT0oM+mhALR2e4gcRLsNzIIMMujK/+hVJA1TGGq5Nf?=
 =?us-ascii?Q?DXk2fQwcGvyfhkXTBrCq+azCUEzgpnu8OLroFd/rFtdMJx28GViuyQyUYPWR?=
 =?us-ascii?Q?H23UBVzab6d0cogi8we1LDa3d1HviA0dl7XflS/p3nnnphvAqsWv6blNyHDP?=
 =?us-ascii?Q?L0cvqkb8H1CY35l6929qjfREFsnpidwCm2k81/ZnsP/1tPUhdw3xbaefyN1E?=
 =?us-ascii?Q?69a8SbnCAT7Pp7hZPCxvupqDnHRIZz+HwO/AFr8CNBhoofj2YNVvvMqXmke4?=
 =?us-ascii?Q?Z35Zgqi/Zq/6k6Kti5jTdogPdFU05SnrDEi6eZ7xhcrSjV4TH6IV0mE1UF3A?=
 =?us-ascii?Q?aiYKXiXSGkCx3wavw15ZaYZ9/6cZ9RQnw0pKfGNUEJYGXpRjHH/q5eVhzYhh?=
 =?us-ascii?Q?hwVXgF0IzQSXVnfxO7mlRl6ikc0dFCEdB5VJEAn4AaXzJLg+8BYjktgV73ZS?=
 =?us-ascii?Q?eqDF3dam7XEPPd2q7Kk22415st/kVgwcb7YL06xZ5eyB4FWnuGrvxpmNO6Wp?=
 =?us-ascii?Q?zZStZjcB9dz7IWdRygntTdQzZqlRZo2bVwQMI06tJ2bUEv5hWfOk2ZxuBZZe?=
 =?us-ascii?Q?DLBoDytdBZfvTSOKm4J3kePMi7glYLMkMwFErYogyD/rhwC/vn8QTaIzNRgH?=
 =?us-ascii?Q?1PanX+AmWx+Y1N8bZjc/FDo5+k9dRXlGljYnLJJWwOmV54UbAUMCZfLNHwBv?=
 =?us-ascii?Q?lgaHtFKOX1rem+M06d6fEg94eVGx3veNrEPM4j0Jyz9lJyMNF6TishcLNyJP?=
 =?us-ascii?Q?j6GunP4kpRE6LQM1CgraevDp9WabJzfs39SCmS9z7QrGprxkMf4KiYvMIjxh?=
 =?us-ascii?Q?tOeR0CHd3tqSup5L1KZLpnSNEkRljAbcR5OcsGlgvJvrM7LWXajLxxSsuBOa?=
 =?us-ascii?Q?s3aKgBU/gqKGVNf2x3nJ4c8GJ8w/gwMusQ9dKAukybjjpnoM2xrEV/cHJdt6?=
 =?us-ascii?Q?NP871PsqgK3+dRmfTht/2o6QKuTND46MZr5gjdrnKujsTy4UySza2ve44FnN?=
 =?us-ascii?Q?qsTw8YxUxvwmJwXF9zqKTT3MBAxf+doBNAGqwWXp5APB0TP6H0IfNXuRjWjw?=
 =?us-ascii?Q?4IJWZ7quQjkAFU5svDmqL4wAOeGYN8vczCjcx/8JHwGDHfhLjKTV/HO2MRXv?=
 =?us-ascii?Q?CzQpgO0r7egIA+Ypq7WkQ2i3pN4vxj6jXSw567vuPnWuRmpEwPFhaEtgg7E4?=
 =?us-ascii?Q?qUCkj/CRG3d9XCy8Sn/MRajrcCS1FC1creEYfgkEGgH5NE797yGGhFLd5XI+?=
 =?us-ascii?Q?b/s+7yj1VSHh3abXX45Pi1XCQ6DodacS38ys91YbIcfdfilClbXm+npZMahB?=
 =?us-ascii?Q?NbTN+U5ipBrsGlmGwLPZWkX3SztEcmIrNGFhodWwX+FW4j8y/x4D+bNDKEPn?=
 =?us-ascii?Q?rYuF9ASt3wgyOXJ+tQf4VG4DryCoCAf1sDOXThWXdpdZbnD0T3U0hCibynx7?=
 =?us-ascii?Q?tj3YXg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fedf70-3c44-47b4-7ba3-08d9f6ed499b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 16:55:25.1094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1WMIZHlkCt3woRa08vR83in2Lf2aho9/myjgjMol3w0qc5k+V73lFtAqj26BqGZOamLKt5vTFw8d8rf+Z4RigyL695ApPEelxf5V4Y1RLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3358
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, February 23, 2022 =
5:16 AM
>=20
> Currently there are known potential issues for balloon and hot-add on
> ARM64:
>=20
> *	Unballoon requests from Hyper-V should only unballoon ranges
> 	that are guest page size aligned, otherwise guests cannot handle
> 	because it's impossible to partially free a page.
>=20
> *	Memory hot-add requests from Hyper-V should provide the NUMA
> 	node id of the added ranges or ARM64 should have a functional
> 	memory_add_physaddr_to_nid(), otherwise the node id is missing
> 	for add_memory().
>=20
> These issues require discussions on design and implementation. In the
> meanwhile, post_status() is working and essiential to guest monitoring.
> Therefore instead of the entire hv_balloon driver, the balloon and
> hot-add are disabled accordingly for now. Once the issues are fixed,
> they can be re-enable in these cases.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  drivers/hv/hv_balloon.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 062156b88a87..35dcda20be85 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1730,9 +1730,19 @@ static int balloon_connect_vsp(struct hv_device *d=
ev)
>  	 * When hibernation (i.e. virtual ACPI S4 state) is enabled, the host
>  	 * currently still requires the bits to be set, so we have to add code
>  	 * to fail the host's hot-add and balloon up/down requests, if any.
> +	 *
> +	 * We disable balloon if the page size is larger than 4k, since
> +	 * currently it's unclear to us whether an unballoon request can make
> +	 * sure all page ranges are guest page size aligned.
> +	 *
> +	 * We also disable hot add on ARM64, because we currently rely on
> +	 * memory_add_physaddr_to_nid() to get a node id of a hot add range,
> +	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
> +	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information for
> +	 * add_memory().
>  	 */
> -	cap_msg.caps.cap_bits.balloon =3D 1;
> -	cap_msg.caps.cap_bits.hot_add =3D 1;
> +	cap_msg.caps.cap_bits.balloon =3D !(PAGE_SIZE > 4096UL);

Any reasons not to use HV_HYP_PAGE_SIZE vs. open coding "4096"?  So

	cap_msg.caps.cap_bits.balloon =3D (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE);

> +	cap_msg.caps.cap_bits.hot_add =3D !IS_ENABLED(CONFIG_ARM64);

I think we should output a message so that there's no mystery as to=20
whether ballooning and/or hot_add are disabled, and why.  Each setting
should have its own message.   Maybe something like:

	if (!cap_msg.caps.cap_bits.balloon)
		pr_info("Ballooning disabled because page size is not 4096 bytes\n");

	if (!cap_msg.cap_bits.hot_add)
		pr_info("Memory hot add disabled on ARM64\n");

>=20
>  	/*
>  	 * Specify our alignment requirements as it relates
> --
> 2.35.1

