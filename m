Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708FD4F9976
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiDHPax (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 11:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbiDHPao (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 11:30:44 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA73411175C;
        Fri,  8 Apr 2022 08:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDXvJJvU63t/WePcJq0h+av9XwKgsmY26ZuCFdQCgfIFkq18GnATUB+AV8upiEQYqCXTNjvmefMDbTcz7u9hXL/5u0TqdtZBXNli2GrpwqVPn8h5MtDzFM4d/rw9zqSUw0HW742AesoHA6z6w/W9EoTv/abk8VGpItFjoFUu3YCU6/xoE5hQHi2c0hAf4i3IhrYp8WIJb7ZGfh/lCEAWebm09SZtKrCKgQvx/MdrBhmddrEVaEWytAB8FjvtRsOuTMb+fpMEBCz9RohtdgVdNQYqHXrvCgr+J4mKd3goZTbDK23CmWOhKwWEXdKnmlO/dSbJ9kJRTDqvmvIX14F/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsdmyXyo1Bg9f3smknFQX92dd6oGufTYPcOniHCnEmE=;
 b=hyBX6M2lESoHucrVzDcpVtTMLGuDKniXpzsUAyJazp6dCCcYCAlsTeWWcDFr85nqeq3UCT6cjDyKFw302bYANX0w3hqtZWQkh23tew9FYpzxpwpAL+HXm4j9SsWVNXsjPv16s9PgnVYLr8CD8TrPn25UnuaUFa1XVV6J56bNaK49uEn01a9C5hpXv/FS6FnSNqU/S/w6pOs25FruTazAVlLUKtaDPaVIK0/jZHafk+asWGVaeRtCqr0K0Gbn22w5fa6yCbJXXbgmA6CQRZRcuRhCFZIUahqZdRkk5xnAOVTE3O6LrU3RxZFftSeVNvHfDobx781k9T5l549C5Ycu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsdmyXyo1Bg9f3smknFQX92dd6oGufTYPcOniHCnEmE=;
 b=Eb2yoJeqBEhJYB0Im3KnYcI1273NIL4vEs14EU6c2ZqH6s9fxi4a3V3aeVcnDMvNgDy2T1vO8aypta2yq2ryMhJW4H3GpH5S5PIX/R7q2sLFjUEizClukxBDudzW3+y0OLK4RzVwqnNC8ARTae/3C/yZceveGMbhaKCBhommscg=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM5PR21MB1749.namprd21.prod.outlook.com (2603:10b6:4:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Fri, 8 Apr
 2022 15:28:37 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f%7]) with mapi id 15.20.5164.012; Fri, 8 Apr 2022
 15:28:37 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/6] Drivers: hv: vmbus: Introduce
 {lock,unlock}_requestor()
Thread-Topic: [PATCH 5/6] Drivers: hv: vmbus: Introduce
 {lock,unlock}_requestor()
Thread-Index: AQHYSjh6DFUxGtO8e0m5GrS3S88ooKzmJXDg
Date:   Fri, 8 Apr 2022 15:28:37 +0000
Message-ID: <PH0PR21MB3025A16C9E729ADE4A3F2258D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-6-parri.andrea@gmail.com>
In-Reply-To: <20220407043028.379534-6-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fef8be5-2602-4b49-ada6-41968e288a44;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-08T15:25:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 546a150b-3b1f-4d46-6de7-08da19747399
x-ms-traffictypediagnostic: DM5PR21MB1749:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB1749A47EC2C3A56338B716A8D7E99@DM5PR21MB1749.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5l/MTVoKr7UTdfWzL67ziLcO6LOr2YznR0ePdMU28jW79M3rn7ZBBptdjcFM2QsK70e8u/MyZQS+ndVPXTlri608k+yrNzmDrmJk6R27NUzztTRCa0Rr6Wct0EaB/CnbKpJ6BbAzI2js1qC0P1S+rwRhFJ0HIr7hnkAZv8v3msYXb8ub2FqVu+LG9nBAuSFhA7i/J1zwZED5VTvxcU3y1lTovHw8XtWKT1+G4908aVz8SJ52cBsq6KGtG7nCtF9aC/+Fb7KiEtPziNZVmb4yr8AvTgDwmUv74rtCzaE4PARvofnA3myMf2+nuB7sJvt/PyVT/KkdqkOhUgwkgZQY/+EqwUqTjwBNEfVfHmxIpDO24Q3Ef7eSJnjJVTUkLvNbCiK7UlG+fEef8Uj30KplyxtkJt84m1vU01IBv9D5grgl0xeyKrTN9K31PBz7XGUYIz40Oo5vnkyw6Wa8lVOz7NIdvIjtf4ME7yeen3i9qpLaOThmFSgw3/0ZzT0co8mUx+8Cd3xu0UA66sJJ/xvD/Ir7zurJQGRnh9G+mszETZ8SqfaD8N1eD0BnzuECQ6OHBVlkUqCyE2WCb6ya7rbf/Rz6WGdyWA5ZHl43I998Lo/Ym1gipwtCLxtvJFNilFuEJ9BQySCY4xBr/ClewBCqvUKPhj85hlqMo3Leze+95mihW98iTWp5a1nfgne7PZXA6m49adL2TbwCugAzL/vsyunwYPlHqJSFZUqYnGZNVRiQvlJZ0ou/YtIX2VqWw2CUZ2kI1W1Ll9Zd8Jd7M0Yh6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(76116006)(4326008)(52536014)(33656002)(122000001)(8936002)(66556008)(66446008)(64756008)(2906002)(66946007)(8676002)(508600001)(186003)(26005)(8990500004)(86362001)(71200400001)(7696005)(6506007)(5660300002)(54906003)(38100700002)(316002)(10290500003)(82950400001)(110136005)(55016003)(921005)(82960400001)(38070700005)(83380400001)(66476007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x3WbiR2Pme+U5GAWBdh/6cnbNryMPz3uKViyC5sCHKEPG6pNPdmsKM0JoQ8x?=
 =?us-ascii?Q?xZ8vn02K2l3mA2Bth8GmJhqqkHf7Dm/91tJcNcIdI8+Pc6KU6xnqvopETCZJ?=
 =?us-ascii?Q?j6FOaj9Orf5czyA/NJTxe+xiCLDPu9qfC7sG5CnWvxsU6MK9RgQXvgXQJJSW?=
 =?us-ascii?Q?ZpN+t+RbPwcWt2e+QKR6xdFvSCpC6WU+CGCfu7yOWt6TH1TDiNsxWk8Q90Oh?=
 =?us-ascii?Q?XANRdi9Ux/J6NuDCpbMK5GqusHSVbfSinBdx0Hrw+4rbhT+Lra8LUCy2fTSL?=
 =?us-ascii?Q?khy8xQrSINzSZQfQrC8ZMsK7lkuI7htworSD+WPVd3ca7f2CXWeO5tFGEo62?=
 =?us-ascii?Q?2Osjbwyb+9uhoFLH40LQ3X+ILmJ5Fj8Ll2I0lm7qqmAWCyU+c66qRFuV0dZh?=
 =?us-ascii?Q?5U5Flk08SVZeBpCTt6+hyd6eIBW2RCjkzvQlcvcuhyGcaWN+S64uUoZ/HmbS?=
 =?us-ascii?Q?7RIyrntctgChdN0DKgSrPe/uD6viZpmS/SxaSsai3o9zFBTeb1Oyzv10YxVt?=
 =?us-ascii?Q?bB+2MCnXAdEjqXvDhqwUDEyk/b8ZmObnWsfLlvP63bCZWxAnSmJpnnaCX0hu?=
 =?us-ascii?Q?NTEa5efrBunjAlNRkOECjhWY6z7UMEC+8lIUpZIwu7dvuK9WpIcJd2yyLsLj?=
 =?us-ascii?Q?voakPIfNejzGiW71es19NmzPyvR5TSOKvOgvjRK61Ji5LWUxkraAJMXiqhRm?=
 =?us-ascii?Q?F0WeetihppB62fdp+OTjGPwNM+rJYZ8EhnES8FgMFxp6IyIRnJKuvEdo+9qo?=
 =?us-ascii?Q?tXyMskr+csJRC64ncpktUOAm6HGfMMOkc+bptauGA75LaynkJApp9WlgPL4w?=
 =?us-ascii?Q?cXGuGk9ZwY/TiXFUy5c9XrJyvR+Qyoo05MwKFYWLnajxZNxL/jcdcjmY+1zn?=
 =?us-ascii?Q?9GYl4A2GutI+XYjT3ctn3hUC+YwW1cRHZke/rgCr2vyx/IV6o3zX7JJxJy8G?=
 =?us-ascii?Q?dbTVnPh3bNEJwISkMgBajakY2A3Zi54ehYz63yUDeMT3xGKBhq67CHab492p?=
 =?us-ascii?Q?gfjhuUHOphoZWln2aGxWCG+gJ0QAMWyDClghT4C9Y6Np+bEHyLvRpmAu8zBz?=
 =?us-ascii?Q?ds4OkAlbSnoJcvBTAsKgNj3pKOKtdhSb4ByGU03Rp+lD0gPudbLA4a56gGBC?=
 =?us-ascii?Q?YNI3G17vznrRTrKDPhJ57u5YkU68vjRw4Pb/H8qFjpCh1w08pIvzq4jN/Yul?=
 =?us-ascii?Q?UgYIcrNOLUmLBIirGVyEE76FMLT3K+J1N+GJOilkRRTfe9XSLco5mHXO94JW?=
 =?us-ascii?Q?AR/imc17Fh1o51hXDJOgJX5ZWvDNLPDfn4e62Z475B2ORCbdW9GREY/EkI11?=
 =?us-ascii?Q?saKw+Sd/tT8BOSsyM05iZibPBmhFyb+gqqTuEt48A4dZxhtGi3kG0KToV5KP?=
 =?us-ascii?Q?Fhe3qeoE0uUs7I7y4q2jZ/F1vUKfIympk95KA++TWeVvDq2e1WqmjQkuq9n5?=
 =?us-ascii?Q?jkzqSByQpvvjjvQToM+lcflAABuBEFS7V1xbHSTno9cgF0CjX2lSUwLkAa2m?=
 =?us-ascii?Q?Q0OdM63ZUatXWwxAStm/FZdDbkBAuXQyjhvFr2Y5MTijIywSVeNUc0/xK4V6?=
 =?us-ascii?Q?A4wJn83XNGYuhJbcC9w2o4HXENlM33GA2esRGgf9shOF6YWs79kzghnBjdl+?=
 =?us-ascii?Q?hAnt58ku296fpw18NndnAmjnQbWrKobgCP0fJS/3NFwvbMYZMnR4KkOHW7oA?=
 =?us-ascii?Q?5NM0RzYisGls/zBW94kXf4ZV3LyBnk0J9k7bF5GlNMvO2Wji17XH31F+T2iq?=
 =?us-ascii?Q?unmP4ftwXd4vn3+tOzKCJzCFUqFfsxY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546a150b-3b1f-4d46-6de7-08da19747399
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 15:28:37.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEqFe/sYQ3UoXRHwmTvjV/NTHrYYK1n/790YqNIzs93X1GvK7UQOoTFL+3nJ5DzMhLuVlTsWf13d5XLu54UJB1FgVpeKYhy5/3zrC2+d/Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ap=
ril 6, 2022 9:30 PM
>=20
> To abtract the lock and unlock operations on the requestor spin lock.
> The helpers will come in handy in hv_pci.
>=20
> No functional change.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c   | 11 +++++------
>  include/linux/hyperv.h | 15 +++++++++++++++
>  2 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 49f10a603a091..56f7e06c673e4 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -1252,12 +1252,12 @@ u64 vmbus_next_request_id(struct vmbus_channel
> *channel, u64 rqst_addr)
>  	if (!channel->rqstor_size)
>  		return VMBUS_NO_RQSTOR;
>=20
> -	spin_lock_irqsave(&rqstor->req_lock, flags);
> +	lock_requestor(channel, flags);
>  	current_id =3D rqstor->next_request_id;
>=20
>  	/* Requestor array is full */
>  	if (current_id >=3D rqstor->size) {
> -		spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +		unlock_requestor(channel, flags);
>  		return VMBUS_RQST_ERROR;
>  	}
>=20
> @@ -1267,7 +1267,7 @@ u64 vmbus_next_request_id(struct vmbus_channel
> *channel, u64 rqst_addr)
>  	/* The already held spin lock provides atomicity */
>  	bitmap_set(rqstor->req_bitmap, current_id, 1);
>=20
> -	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +	unlock_requestor(channel, flags);
>=20
>  	/*
>  	 * Cannot return an ID of 0, which is reserved for an unsolicited
> @@ -1327,13 +1327,12 @@ EXPORT_SYMBOL_GPL(__vmbus_request_addr_match);
>  u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id=
,
>  			     u64 rqst_addr)
>  {
> -	struct vmbus_requestor *rqstor =3D &channel->requestor;
>  	unsigned long flags;
>  	u64 req_addr;
>=20
> -	spin_lock_irqsave(&rqstor->req_lock, flags);
> +	lock_requestor(channel, flags);
>  	req_addr =3D __vmbus_request_addr_match(channel, trans_id, rqst_addr);
> -	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +	unlock_requestor(channel, flags);
>=20
>  	return req_addr;
>  }
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index c77d78f34b96a..015e4ceb43029 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1042,6 +1042,21 @@ struct vmbus_channel {
>  	u32 max_pkt_size;
>  };
>=20
> +#define lock_requestor(channel, flags)					\
> +do {									\
> +	struct vmbus_requestor *rqstor =3D &(channel)->requestor;		\
> +									\
> +	spin_lock_irqsave(&rqstor->req_lock, flags);			\
> +} while (0)
> +
> +static __always_inline void unlock_requestor(struct vmbus_channel *chann=
el,
> +					     unsigned long flags)
> +{
> +	struct vmbus_requestor *rqstor =3D &channel->requestor;
> +
> +	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +}
> +
>  u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr);
>  u64 __vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_=
id,
>  			       u64 rqst_addr);
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

