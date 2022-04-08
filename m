Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210C04F9959
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 17:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiDHP16 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 11:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbiDHP15 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 11:27:57 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B903981B;
        Fri,  8 Apr 2022 08:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXanWwtldOSeW6DRWqtMijwN2D78DqJpTAZmzvbvr7tR8yVbobTpU18dtu7Zn9mn4Vdx4DzBF0sDQM9eW4yqyNoyVktgcAmqXd7QYj92e7y4Sly3le3bQUSzu5Y0Uv2D5T1t1zPHvmiqDEH4WqIIpDN2WtdCBRG5mrgS3Az4Nw/gmDLGLVJwPp7nhVfiUW5kNgrGgXr4WOSYkbdSMnwq7Zp+Mkcs+zKQM8vlce0VwyjbsrJvU3oIqEKTmdIF5Yfmfmz00YIuXfDoIWCC28Ychec1qCbRu99sWbNT/VyuO56kRCpTHVfvtBVtti+wiYgNJV6gndAAkuIcG5UJncgyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wsuhz+ZEUXOxY4xMEsV0ldODka/7kY+qeJ+epKCUEHg=;
 b=Ba/NOA643hacgPrlsQUTK2skQfVU7WuLmV+Yw949ScWnXq/Iq2U5fxysvQfcG56RnbR4RsFI3XU7BfbkJit6aF++ODmegAHyr8Z+/d97vUyGaK/dZY72enjT0dDSDXul2CXVH/nfk8fdXGSPbW68zbpyc1vkVXLjiyjGOoNJFKgJSVrYPAnbjGGKfxz33ur0BKUf7BHdk323EEIkr8EbHu1mKQvBgJrp3QS8cuzTvQoy9Aq5K+sq3cBmCiTx2G54PdQdDKboPtDw+D9IWikTF84IBGV/BjdugJk9mW5QlZybAnQwKpPwkTk8RR5RknbbiEdKHzv/1lB0iDHmqYY+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wsuhz+ZEUXOxY4xMEsV0ldODka/7kY+qeJ+epKCUEHg=;
 b=I1EaMpmjzZo5L0em2JoLOmsOyRH1ph8F3pybUD1JAvYraY8osqNWOoXXzw0xiVOhKGvLPQlv1SweOZGcBe0KC2apnNkkrrzZu1HBfhEIjNPFo2HGiwSX9bk6hpHT3Hdqp5LmkjF53+sMesm7PSoQMYDSaebbshsbPR3jxFMuBH4=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM5PR21MB1749.namprd21.prod.outlook.com (2603:10b6:4:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Fri, 8 Apr
 2022 15:25:49 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f%7]) with mapi id 15.20.5164.012; Fri, 8 Apr 2022
 15:25:49 +0000
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
Subject: RE: [PATCH 4/6] Drivers: hv: vmbus: Introduce
 vmbus_request_addr_match()
Thread-Topic: [PATCH 4/6] Drivers: hv: vmbus: Introduce
 vmbus_request_addr_match()
Thread-Index: AQHYSjh7yz5y0LU70k+FVkT53LIUc6zmJBNg
Date:   Fri, 8 Apr 2022 15:25:48 +0000
Message-ID: <PH0PR21MB3025D745B0F3FA8893B32B39D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-5-parri.andrea@gmail.com>
In-Reply-To: <20220407043028.379534-5-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=220e836c-d89f-4c30-86c5-b61755a1fe71;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-08T15:21:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 264d5d17-0bcf-4c4e-cb0f-08da19740f74
x-ms-traffictypediagnostic: DM5PR21MB1749:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB1749F5DE8DC8AD0FDFC6C239D7E99@DM5PR21MB1749.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8TyffkYUrbzoEgUx4SSaSxoMLOINjaUBgB9+36U1NnA82uoRp+T3uQ3JjpXlWx8cA94gRFh9Skwg0XIOZw88tLYDilY6QDNW32MWdvtiYz6auHpqx+PU4exJdqi8j9MITfWqpMRMQ8QWwAuR55LThNe+gOryLzntaPrpbenMdO/uuPlmrUiRhlloLgK2w9AtljfDX7biXsJ1reIEOWx+EFcvyedfqKsnRs4dbM8GaRZdZqjKe5Gmt4ikoGs8ql1yjz06LDtxEc61IqI5iJR7ICPrsdZq8XmcbyjZ8g+wVQ6V9zi/85c/naXJfFVqrW+rGKywO3gvRx0TSr/J109XkazTjreyll3YoAxggMgbWzECM9/cNq/yj3zNJ6E8vsH0cR7Lyy6cItWtViDIhN7sFjsjFAvQn1freEvcPbUzsU0bubhLQvG46h2pFJFd7XX5g28uUGE8pMPwcK1/9oNXGqwfY59lQy40xKp16VgqKsI2BD53z0gRcH3GDJ/nW/oEct9QozYjO5ZGrBWJOznNDCYPei2BkwKG6aWHp2pczDFZoXNgrdtTqTmfFbK+7SlO7eXGlTf76wzcHyz2jaxuz/aW7SnCg33wfjLzYv5HHXhUrLDMCSMTuqHgdxwYXCtCzdwmUXE7CBPSjZ7ETVqvyLYw9FVzIFwsW+ewJQ1gYxF+OrEAlVx+TxNtQklsrxgi3g5d11f/WH7m8nKVKPZgn5Ufvvzi+r2bCrqhIKSSjjuDNOh/Hli6+aiWKVN4p/XN+UL4FZbPma4+UTVnNwMAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(76116006)(4326008)(52536014)(33656002)(122000001)(8936002)(66556008)(66446008)(64756008)(2906002)(66946007)(8676002)(508600001)(186003)(26005)(8990500004)(86362001)(71200400001)(7696005)(6506007)(5660300002)(54906003)(38100700002)(316002)(10290500003)(82950400001)(110136005)(55016003)(921005)(82960400001)(38070700005)(83380400001)(66476007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+zs+96KfKW88t20+5hs/mSnpgGV0wKPoaUbeJxMXWKZt5laI4HIiBMmLB1M?=
 =?us-ascii?Q?BVbIoyT+jXVq/gEhKHIRnB1bv5EKDOyhnPT3yWwBgy4vO+FTiYQn7YHX2hUI?=
 =?us-ascii?Q?a+AjmPOrMfj3vUHxV45aamoON5mZdGzOrz+ZY2J/BsLZrmuoWkb5q9iJW1oO?=
 =?us-ascii?Q?/Sd+XPGEeo9VJbiQk8a3inuqSdQvEouEfPsg2vSxeHGLksxc7WEqc8WwlLiC?=
 =?us-ascii?Q?lzIozK4wLK9En4YBX3Tkf+K1/ti9e08kQh1GlqTyT8zZH6JYxjlygyeDVqjv?=
 =?us-ascii?Q?0ldWO+IW/qJ23JMgsQ1/urQ756+cMp/kt5gZ5pNOcT1gM2BMEUNknJb6OUXT?=
 =?us-ascii?Q?bL3AzqvbsVqYCGjzXtirKW1bZ69L4vccoP1LsxjU5C87hAt1bxmqdTc/BZ4z?=
 =?us-ascii?Q?28Z0J4vtk7q6FgAzQ+T7jUkMVyPoc+Y+6DFN9oEfvc6Tn8FDYXg409PH9F5R?=
 =?us-ascii?Q?QWgSX5xg9yGCXTridF4HaecH+1sPIXaGrqtQysifXNqKA3ieU2K80WE2HnQT?=
 =?us-ascii?Q?aV7OSaIfD3nuAfqSFxfatDKiKC/eL6GqbON42by4UWOIVfC9HcZ27hZVhr0N?=
 =?us-ascii?Q?Xq1wK3p4FY/xxcVOQInMtRc6Lr2l9GiORc3aPw9swq2j2CSm/GNnI4n4+2KP?=
 =?us-ascii?Q?O5+ge7Eypb6C/RY4iINYMkrBVwNAcRWBBv9tlYFTiwXnK+PPDcdNzL1wfoZ9?=
 =?us-ascii?Q?/Ik/L4EFaZ0DzvbiHBYM9Bqrav090oDdq0wr6hYgnqtN2XKlLLqX/ngRHNuV?=
 =?us-ascii?Q?ozds1MCLMLKNrSxScGJYAGVIF/2RLgFFeM7JVZuAvIUywjV6qqyplkBLVot6?=
 =?us-ascii?Q?XMCvVJjBEirOdkKbDqc+dLGSwksRkKeR/b3bhiQ/pPgvJH/vMq0K7FWfrT/U?=
 =?us-ascii?Q?AwKainf23F3W4iSSu5Bfuu+0Xt/3Lvue1zosiPIXGmM6KnCMau+IToFQFQgZ?=
 =?us-ascii?Q?H7eVgflnlpRXFH9IMjsC0oCBFijxkFjuIxVO1A4KifsjSYMkgDh3+Gn85X1z?=
 =?us-ascii?Q?PACnSOprOx9Rj/HEhpTjlpjfKP3zXMJKSz6FNEajCzvJzbE41kl48i6/0j9y?=
 =?us-ascii?Q?biU8Y1HoWUW//AUdyDU72KqPjM+E7b7Wkf2h8Iz9P3C7VZs9oqK+53g5iToR?=
 =?us-ascii?Q?16DOr49tx+98wy7KWvLvtiOBJllH4fkGHkInfXLtz1eJ2Js2fOuoa4Nbak7y?=
 =?us-ascii?Q?N76uQxHrS0LCVM8RDsGaTKLDFaPk+dyO2JjBhvXnwOeXZN8dUWW23FUgTKPx?=
 =?us-ascii?Q?ojx4U1GvkeAXYEQvLeFK+2aEkJGO4O7uKXwOb2CNcCSWhdYrCjdkYZUXKnkR?=
 =?us-ascii?Q?9sKObZsm/MxDBw//yf2ZH/jlAh/qMg/cFskk0SxjFmEPYzMuuT3PAgiywR5g?=
 =?us-ascii?Q?1gyyC1AHiXqqYNUDi22yoJby4yNX4LQ4t5J5uBDI24LSCl+Z0prGj3Xx5SqA?=
 =?us-ascii?Q?utSdYoXFXsp4I9EOxaSf/J95u4qaq55AIJNMKlpDasRMMsiaNl+0DTuO5UkK?=
 =?us-ascii?Q?AiP0SCILZlEQzig2Ty9KSAZk91pY3yDLq+Hl8t9gheRjdPUy2v4Vvati2B+a?=
 =?us-ascii?Q?2DM1grxh8rENg06fFDkUymJYHqJBn9FzG3b6dnAwDsF6HHFbYg1Ha+kR4+G+?=
 =?us-ascii?Q?biy1ippntrD4Gw1eBT4WV6lLhAa6OGO9TMFgTaCkCTQt1gIKf68aaVhJ2gXz?=
 =?us-ascii?Q?7bqr4g7flhgBkE3CkTXi4J+wHqo2PIu1jrIbom9ag9223Mf7LyHAsj1e1JGS?=
 =?us-ascii?Q?4Sw3zfAyprzo4E/p8O4BYQMZ9TJcTtc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d5d17-0bcf-4c4e-cb0f-08da19740f74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 15:25:49.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 601hEpJ88uFZIxfyks2gydzyFjiWkcydfg+XlyUN8Hd4RpCMyvS8wWlsxtG97R6CeDTGQ9wvS806pEjXE9ypzThnZ/skb+kiLQzohUsx44A=
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
> The function can be used to retrieve and clear/remove a transation ID
> from a channel requestor, provided the memory address corresponding to
> the ID equals a specified address.  The function, and its 'lockless'
> variant __vmbus_request_addr_match(), will be used by hv_pci.
>=20
> Refactor vmbus_request_addr() to reuse the 'newly' introduced code.
>=20
> No functional change.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c   | 65 ++++++++++++++++++++++++++++++------------
>  include/linux/hyperv.h |  5 ++++
>  2 files changed, 52 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 585a8084848bf..49f10a603a091 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -1279,17 +1279,11 @@ u64 vmbus_next_request_id(struct vmbus_channel
> *channel, u64 rqst_addr)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_next_request_id);
>=20
> -/*
> - * vmbus_request_addr - Returns the memory address stored at @trans_id
> - * in @rqstor. Uses a spin lock to avoid race conditions.
> - * @channel: Pointer to the VMbus channel struct
> - * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
> - * next request id.
> - */
> -u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
> +/* As in vmbus_request_addr_match() but without the requestor lock */
> +u64 __vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_=
id,
> +			       u64 rqst_addr)
>  {
>  	struct vmbus_requestor *rqstor =3D &channel->requestor;
> -	unsigned long flags;
>  	u64 req_addr;
>=20
>  	/* Check rqstor has been initialized */
> @@ -1300,25 +1294,60 @@ u64 vmbus_request_addr(struct vmbus_channel
> *channel, u64 trans_id)
>  	if (!trans_id)
>  		return VMBUS_RQST_ERROR;
>=20
> -	spin_lock_irqsave(&rqstor->req_lock, flags);
> -
>  	/* Data corresponding to trans_id is stored at trans_id - 1 */
>  	trans_id--;
>=20
>  	/* Invalid trans_id */
> -	if (trans_id >=3D rqstor->size || !test_bit(trans_id, rqstor->req_bitma=
p)) {
> -		spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +	if (trans_id >=3D rqstor->size || !test_bit(trans_id, rqstor->req_bitma=
p))
>  		return VMBUS_RQST_ERROR;
> -	}
>=20
>  	req_addr =3D rqstor->req_arr[trans_id];
> -	rqstor->req_arr[trans_id] =3D rqstor->next_request_id;
> -	rqstor->next_request_id =3D trans_id;
> +	if (rqst_addr =3D=3D VMBUS_RQST_ADDR_ANY || req_addr =3D=3D rqst_addr) =
{
> +		rqstor->req_arr[trans_id] =3D rqstor->next_request_id;
> +		rqstor->next_request_id =3D trans_id;
>=20
> -	/* The already held spin lock provides atomicity */
> -	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> +		/* The already held spin lock provides atomicity */
> +		bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> +	}

In the case where a specific match is required, and trans_id is
valid but the addr's do not match, it looks like this function will
return the addr that didn't match, without removing the entry.
Shouldn't it return VMBUS_RQST_ERROR in that case?

> +
> +	return req_addr;
> +}
> +EXPORT_SYMBOL_GPL(__vmbus_request_addr_match);
> +
> +/*
> + * vmbus_request_addr_match - Clears/removes @trans_id from the @channel=
's
> + * requestor, provided the memory address stored at @trans_id equals @rq=
st_addr
> + * (or provided @rqst_addr matches the sentinel value VMBUS_RQST_ADDR_AN=
Y).
> + *
> + * Returns the memory address stored at @trans_id, or VMBUS_RQST_ERROR i=
f
> + * @trans_id is not contained in the requestor.
> + *
> + * Acquires and releases the requestor spin lock.
> + */
> +u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id=
,
> +			     u64 rqst_addr)
> +{
> +	struct vmbus_requestor *rqstor =3D &channel->requestor;
> +	unsigned long flags;
> +	u64 req_addr;
>=20
> +	spin_lock_irqsave(&rqstor->req_lock, flags);
> +	req_addr =3D __vmbus_request_addr_match(channel, trans_id, rqst_addr);
>  	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +
>  	return req_addr;
>  }
> +EXPORT_SYMBOL_GPL(vmbus_request_addr_match);
> +
> +/*
> + * vmbus_request_addr - Returns the memory address stored at @trans_id
> + * in @rqstor. Uses a spin lock to avoid race conditions.
> + * @channel: Pointer to the VMbus channel struct
> + * @trans_id: Request id sent back from Hyper-V. Becomes the requestor's
> + * next request id.
> + */
> +u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id)
> +{
> +	return vmbus_request_addr_match(channel, trans_id,
> VMBUS_RQST_ADDR_ANY);
> +}
>  EXPORT_SYMBOL_GPL(vmbus_request_addr);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index a7cb596d893b1..c77d78f34b96a 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -788,6 +788,7 @@ struct vmbus_requestor {
>=20
>  #define VMBUS_NO_RQSTOR U64_MAX
>  #define VMBUS_RQST_ERROR (U64_MAX - 1)
> +#define VMBUS_RQST_ADDR_ANY U64_MAX
>  /* NetVSC-specific */
>  #define VMBUS_RQST_ID_NO_RESPONSE (U64_MAX - 2)
>  /* StorVSC-specific */
> @@ -1042,6 +1043,10 @@ struct vmbus_channel {
>  };
>=20
>  u64 vmbus_next_request_id(struct vmbus_channel *channel, u64 rqst_addr);
> +u64 __vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_=
id,
> +			       u64 rqst_addr);
> +u64 vmbus_request_addr_match(struct vmbus_channel *channel, u64 trans_id=
,
> +			     u64 rqst_addr);
>  u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id);
>=20
>  static inline bool is_hvsock_channel(const struct vmbus_channel *c)
> --
> 2.25.1

