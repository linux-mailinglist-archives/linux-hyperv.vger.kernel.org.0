Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9490B6012F0
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Oct 2022 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJQPtK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Oct 2022 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJQPtJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Oct 2022 11:49:09 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020019.outbound.protection.outlook.com [52.101.51.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D560532;
        Mon, 17 Oct 2022 08:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cruCGdSEgehFyO3xDhth3yAKKnVQW/lly/cQxGAT/iQ5Pi4TJ4f6cc2o0f8pwDGFZbizrxuA/oQrtgqhOhGUkH2fmxuzXI51/jS07JzCwOOescrOw8LVXhTwZsybu7AjGhQRaactxk4sSzuHbNYX89ttkRqT74iDsO/aK++qC+vpRCqPs1WloR45uqtviramfeOD2mMZeTF87tOpBPwdXTgG4NqjIvAOeeG4vhetR0QAYlFtosN+J9Shv4uxyFrw0P12YPa0qPRIBcLxSmSG1gpnmIcQ25+9/OJqG0XVqi5FG2ajsAb7qofnZ9sNaNOrgNi+P15G5CpgD9CWz0Zvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gomnQbVfChK70GoAf8o9v7Wv12Xa5qGP/AoIft+1/x8=;
 b=aqUCMBvrFpo/rHMLhG663pv3rfAkdQRczsfY3axM7hbJ88/+3nnIQMRntVYd2jQRmPL6PtCB0FEjaaaBc9lhBmOUn1+hGsNRMzeVvomAgRwmJbP7GjnsT/eub0VBsHfObL5tNg+5MP1vNDtbBPtW9qCiGJrvz+2LKNNs9iq5x9re7sMhIAJWvvUfLwVSOq/yXxqBINR3D1kZgRXiyoXUa/XfJoKd/Th6WoVbBtPluUymaCksNHnnwqdSW1BIKW7xGW1TFf7sg4ABQ7WcGP5uCkihe7KlR6K/XJ4B9+AHSnTriOOrj3WhqRSpzeX9YWYFl7CtQ9ALufAdYV/WKsGvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gomnQbVfChK70GoAf8o9v7Wv12Xa5qGP/AoIft+1/x8=;
 b=JBQWg8bsruZ01ScnomDpep/Yj5JL2uyZ8yb+lSsOMAF19XqiafjSmG1kk1OTEPFrmq+fhs0TDd/Wt05M0dfq8uxMtGOxszLQJfIxusC6JOhLV4EIBQ0moVlob4dmCPY0qNbg5T3epvv8Or9S5K3f5FlxloL4MHPEK6jlEIVEe5g=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by DS7PR21MB3221.namprd21.prod.outlook.com
 (2603:10b6:8:79::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6; Mon, 17 Oct
 2022 15:49:05 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::af9b:5444:77eb:448d]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::af9b:5444:77eb:448d%7]) with mapi id 15.20.5746.009; Mon, 17 Oct 2022
 15:49:05 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2 1/2] mm/page_reporting: Add checks for
 page_reporting_order param
Thread-Topic: [PATCH v2 1/2] mm/page_reporting: Add checks for
 page_reporting_order param
Thread-Index: AQHY1JIpvIe3FCfJ70OGWTCfBPqSfa4S1qDA
Date:   Mon, 17 Oct 2022 15:49:05 +0000
Message-ID: <SN6PR2101MB1693F49C9CE71B98781BAF6ED7299@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-2-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1664517699-1085-2-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4c8f230e-6d2a-4583-bff3-6e432566b9f8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-17T15:48:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|DS7PR21MB3221:EE_
x-ms-office365-filtering-correlation-id: 3d1a0c65-5ec4-4c6d-932d-08dab0571ec5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fKEzR/1yohXCIxA2KDMIpHfW+9nuZyzurA2MzawCqIf5M+HuLQSUFDcS52IpwCp/tTVPF7mJMGhLsK0GWR20WPPW2ESsmFw80ypSvh9JittoghcKxv8n0MI043DkV8T3NKWKDRDj3gRrdC1HO4Y2YZ42h16BYU0ywduY+PqlgERmE06XG5fIxEdsDYl/fEBzJXPn5kXQe5TaeKydXzpdc9iB7xovxhnaPEscb/z+3YcsobeggiApeu3JMqAheFFqGn9mefYBE5GGxX19MRtxSFnlyt1Zbv058uFVpFmuHnR6Uymm2o5j4R7ExsbL1ma+JEH7SjfumgpeJElBTanw4NhAEFuK9IauEQmeur8HcxUNkkDfTfOTJZr2f13Ew0e10zZFUg2JBed19qsUOc0QKnPNN2TkSxt1/hk61Gg8KZBEbP99FWBPVhl3mlit94M+yC2hOCe71pd0UL/+nPCYp4hX7pMDtATmMLBBNc3X2hBgAGuW/A0rpqJOjqAfDfi1LA9RvouuaAbydEIqGv3u/yOLG3QIajTuZgxC5fqCcinAnCIeeulPnlJGvdpAYJQH1p7J8tvZ48QrrEgr1v6N1LwImjF4PSZN8P+gQzp89Zgnk43T4cnQTEOucGLFuMhQNd2vevB9dhaiB8T5CVRAe5riMTfUvny49pdTJn8p7xNPbJqh1OcFpQpWZUny2DXWKti+o6P5Nq7Uo6VMLox8pDJdv5DVQ1iOxAOqsgWIaFUWovDYwIbKWwAOYsA8av+b05Apd2t8MD/Jju/uGr7pB9qF25fKzhDBL3XPLfJdB+p6Bzn+lCzVKE514Z0vPzod
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(38070700005)(8936002)(86362001)(66476007)(9686003)(186003)(82950400001)(122000001)(5660300002)(82960400001)(55016003)(2906002)(66446008)(8990500004)(71200400001)(66946007)(64756008)(107886003)(316002)(478600001)(26005)(41300700001)(66556008)(76116006)(4326008)(52536014)(38100700002)(6506007)(10290500003)(33656002)(54906003)(7696005)(83380400001)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rSGXa5aymYSIp8Bh/WOMMBSUuxy/jxVR+EahE7nfZSqxLXPH0aJggYeqgwoa?=
 =?us-ascii?Q?3GUIl2VCgQYp6iOhdaVI9WcbxVTIRKDVBkLstmfKwgu3O0Qn7YJ0szQOy7Te?=
 =?us-ascii?Q?EUKxu3S+Y34SuMp562rOfxhcVLQCrhJ+0x1P2JA6E8bkyIn2vlWkZiDh6cyg?=
 =?us-ascii?Q?v78UPO5anJ2Mk5zinYZXP8yL7Xi5Ay7sFZEHCFtX9ZvGqMyKvh41gQYbMlSF?=
 =?us-ascii?Q?5+n2auRk3DqkNbuOkdd9l+TDdO8CurJvi0Bu7b9hie7JM9L1zN9OyYZ/yfEe?=
 =?us-ascii?Q?iyrWLIcV6rqBR4ZotrHdlcgrOaKnhTpBWJaqT1hDIesdgL+hqNvvusv+1bns?=
 =?us-ascii?Q?ohCo0MaiXgYDBTdc8T/MZ7HUkVU+N3SqKlA1R/5Pte5mvYe79ncs1GXW3Ilv?=
 =?us-ascii?Q?lIWL2xMCwz8TTBw19rKh1yOGSGDWoHn2sFoGRjIG20c3Bv9c26TXIFAulXQk?=
 =?us-ascii?Q?rQwd5HwxswYTNd6JHjHlCQUPv2nKjO+ARHSnAUYUvE1+zU0CwCthbXDLEo0/?=
 =?us-ascii?Q?1S+fG5ggOQnFpNC98NSY9Mi3GWX9JojJQeTjDubDJxwb+AZ6WhJvvMchksYx?=
 =?us-ascii?Q?6Lr2xK4DgOlFfJPPuK5n+UcAt1srAYTwN8s2H6InsBx2Lr8g2n2sk9s58DaY?=
 =?us-ascii?Q?F4+btE3Mxol4y8eDeNJy15CjnTXaOcPhqwgUkRl/er55hC/QBzn7vhrv6uCp?=
 =?us-ascii?Q?iQt7S4Bei2Q3kInCLzF95I3XfFWTUvyW9u6iyxz+0abLwOwoCB+HCEN0L4BO?=
 =?us-ascii?Q?x2BlbMhTyjoxgX6wKUz8ix2t93sf4ToV1n0O4DaoFRACLi8dpHDV1hnNHV/L?=
 =?us-ascii?Q?s66+bVmL6IDFXI9a2eKaPKbvpLihNiy1QOCsoc63gNIO72FjzlcPD6Oh4cA4?=
 =?us-ascii?Q?b82tz+NZk8Ng07KZQaL3C1Tug0wIti0jSjp/2Ph4FckY1gZuPv/F2COYrODG?=
 =?us-ascii?Q?PZ6scR0IVDxRxQrtHrB2nL6gIHQSn218A7+/evXAGS5UQo+cyCJuiYwg04Bx?=
 =?us-ascii?Q?i0z499fz9wSB+Wt/F5c8zyiFvoaU3eKa/HpC5y6Kv1Yy/O3AcRbtPiQMcKpw?=
 =?us-ascii?Q?saOnkeiXcWYBavDACIkUOncwWDnUKubCbTY7RMaBpf3CkphnZyhMMwoomRL7?=
 =?us-ascii?Q?7l0/F6/LLPi5YkuvVJMYaaBmIB8YDx8clZRaAa2uf+DCDpAdXDli/WV9Koan?=
 =?us-ascii?Q?x+PZ3KMIFpbYdnEDG8REIYjwCjTq8ISA6UNLbpSQk4a2GheJwFWkJ/VMLw2w?=
 =?us-ascii?Q?JUi5ZUnwRdYggCfLyqOt5DuLy44VDOrmZ4dhl8GLLBErvwyOpkRiwRDXPSxq?=
 =?us-ascii?Q?66Fpbf4x9g6RYO9c+1xWpoHn+xT+ZPJJ0cHvnaS/IquVfO2WlwKzUqSxRql2?=
 =?us-ascii?Q?B9q7ShKHNLyqNWUMU0NpP+CsrhElPXrI/YGTRmwIEhR18Ue9dRJQYAHyWC4B?=
 =?us-ascii?Q?KCCNwFDm4eX2DGW3HNWrHNwliH6175cN6GcQ+fZLsda97fewiFZCrA75QsZ/?=
 =?us-ascii?Q?dQVkr9XIMGkgXkCstCgG0dl/xFhxCAlcWlNUZC4BvwU04vaC2QnTTDup3tyd?=
 =?us-ascii?Q?4vDvvJ8BOrbqizcq2AxOioIjWj9XQQp9tyC1d6rRmb2LzCTOUmV4uBbqYHuT?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1a0c65-5ec4-4c6d-932d-08dab0571ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 15:49:05.1098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p436Mg4hpK5a43YbHs7/NdjYRUVApP62RU6LLNz6g2ZXRZoj/5kTLTJF128KfVlSbPpU08l7tsYzCWEsP24sEFOw9UaOQQ57weDQuN/bBgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3221
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Thursday, Sept=
ember 29, 2022 11:02 PM
>=20
> Current code allows the page_reporting_order parameter to be changed
> via sysfs to any integer value.  The new value is used immediately
> in page reporting code with no validation, which could cause incorrect
> behavior.  Fix this by adding validation of the new value.
> Export this parameter for use in the driver that is calling the
> page_reporting_register().
> This is needed by drivers like hv_balloon to know the order of the
> pages reported. Traditionally the values provided in the kernel boot
> line or subsequently changed via sysfs take priority therefore, if
> page_reporting_order parameter's value is set, it takes precedence
> over the value passed while registering with the driver.
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  mm/page_reporting.c | 50 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>=20
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 382958eef8a9..29d67c824fd2 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -11,10 +11,42 @@
>  #include "page_reporting.h"
>  #include "internal.h"
>=20
> -unsigned int page_reporting_order =3D MAX_ORDER;
> -module_param(page_reporting_order, uint, 0644);
> +/* Initialize to an unsupported value */
> +unsigned int page_reporting_order =3D -1;
> +
> +int page_order_update_notify(const char *val, const struct kernel_param =
*kp)
> +{
> +	/*
> +	 * If param is set beyond this limit, order is set to default
> +	 * pageblock_order value
> +	 */
> +	return  param_set_uint_minmax(val, kp, 0, MAX_ORDER-1);
> +}
> +
> +const struct kernel_param_ops page_reporting_param_ops =3D {
> +	.set =3D &page_order_update_notify,
> +	/*
> +	 * For the get op, use param_get_int instead of param_get_uint.
> +	 * This is to make sure that when unset the initialized value of
> +	 * -1 is shown correctly
> +	 */
> +	.get =3D &param_get_int,
> +};
> +
> +module_param_cb(page_reporting_order, &page_reporting_param_ops,
> +			&page_reporting_order, 0644);
>  MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
>=20
> +/*
> + * This symbol is also a kernel parameter. Export the page_reporting_ord=
er
> + * symbol so that other drivers can access it to control order values wi=
thout
> + * having to introduce another configurable parameter. Only one driver c=
an
> + * register with the page_reporting driver for the service, so we have j=
ust
> + * one control parameter for the use case(which can be accessed in both
> + * drivers)
> + */
> +EXPORT_SYMBOL_GPL(page_reporting_order);
> +
>  #define PAGE_REPORTING_DELAY	(2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>=20
> @@ -330,10 +362,18 @@ int page_reporting_register(struct page_reporting_d=
ev_info
> *prdev)
>  	}
>=20
>  	/*
> -	 * Update the page reporting order if it's specified by driver.
> -	 * Otherwise, it falls back to @pageblock_order.
> +	 * If the page_reporting_order value is not set, we check if
> +	 * an order is provided from the driver that is performing the
> +	 * registration. If that is not provided either, we default to
> +	 * pageblock_order.
>  	 */
> -	page_reporting_order =3D prdev->order ? : pageblock_order;
> +
> +	if (page_reporting_order =3D=3D -1) {
> +		if (prdev->order > 0 && prdev->order <=3D MAX_ORDER)
> +			page_reporting_order =3D prdev->order;
> +		else
> +			page_reporting_order =3D pageblock_order;
> +	}
>=20
>  	/* initialize state and work structures */
>  	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
> --
> 2.37.2

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

