Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467C250722D
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 17:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiDSPzL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349553AbiDSPzK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 11:55:10 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.57.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6C71EAC0;
        Tue, 19 Apr 2022 08:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pwv0SJX9nXrCfmCcnTnxaTfdr4OgBmGDnNupRXWhfAgE9qZLdvbDDsbjbNNOvkvzsHVGTqj6bNQ3HsJ1JQeT1y2MzQRs5PFXVO6bq/KZOEB4TkH/L6FVVcHH8CnRL+feHksNS4YnqblB+u1x23xASuNNX7VTpTaK44BYgUCZP6wrbG+U8hHjkeFgjT7zZmoS3/c5X71KcRojbRPfd6SgRHC1H+tFaW8k/yKcmci6f7zplUcnRSmRAkkFxnGU0WHC2Hbim3ojIoijNmtmspuj9Hee9mP5CJSLl9tCYIvcXCn71sDu0N7nzpjWSIntJm9SDPS5BHldeL6uOO+K97OzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is35rjqU3X3MKf8HB8aAFGDFCHRydx7mWLYWLQSY1q0=;
 b=gCxCkVUZN6x8YX23QF8Xl+jjV/zxax1+V2TyqitBoWpaHLvfjsdrFUuYtogGQmwHss6TKKaW/zLB0x4MmRhiOaAdn5YTmrYQIR/kQLbu36f0PdGlHR/PC/Hrhr53OpgVj7PYoRsLUR9jrOWA0E9XfgP9G8sMI5tULl/HXEQLrzIdZX+ErDM3tKjsWsJCRFBMOcXeZfgTWwZFVp6l2Mi987aOhoZzYNzPnGaCuz7elqHuTV1ifCvjpqObfrXJn2PRuyFUzo1kdHTg6YrFELWFgMBEDkLvIkTOJDNLxJXzsCJW9QZeEUG5BO7D5Dr1XXwcJxFBKdCteHRoswwyl5VX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is35rjqU3X3MKf8HB8aAFGDFCHRydx7mWLYWLQSY1q0=;
 b=b7SOqQ4HnZ0SswYLQuTErhcbCjuxwW8KQswDAe47hpiGU3pntoAOivA3y5b3vdgJc4CDLRhwh3KfqB16e87NBPfQzTuin3XCmh1NJC1Sry3nGec1HKW+OGsMNcE/L904/xr5ntwbF2tn7YoRzYxh23p62zh8BbNlL8Z3Z22cWWk=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BYAPR21MB1285.namprd21.prod.outlook.com (2603:10b6:a03:109::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.4; Tue, 19 Apr
 2022 15:37:23 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::cc99:c6bb:dfe0:261c]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::cc99:c6bb:dfe0:261c%5]) with mapi id 15.20.5206.004; Tue, 19 Apr 2022
 15:37:23 +0000
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
Subject: RE: [PATCH v2 4/6] Drivers: hv: vmbus: Introduce
 vmbus_request_addr_match()
Thread-Topic: [PATCH v2 4/6] Drivers: hv: vmbus: Introduce
 vmbus_request_addr_match()
Thread-Index: AQHYU+hdDcHds//2qkS0fSAcBZ8gHaz3Xr2g
Date:   Tue, 19 Apr 2022 15:37:23 +0000
Message-ID: <PH0PR21MB30257633AAE686E14257F106D7F29@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220419122325.10078-1-parri.andrea@gmail.com>
 <20220419122325.10078-5-parri.andrea@gmail.com>
In-Reply-To: <20220419122325.10078-5-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34d59756-86f0-4089-a526-a76ed1aeeba8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-19T15:36:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4916c71e-bf06-4630-bccb-08da221a7fbd
x-ms-traffictypediagnostic: BYAPR21MB1285:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BYAPR21MB128548FA18E98D94AB3EFD9CD7F29@BYAPR21MB1285.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sw/jgIGLaWA6BsmqpzoFxMceOEuzJZJcwxgGcsjxT/TjzPLpXRD1TUw4dDN5eQXdileyzsrrQv3/NJpVVFop/rA26yuBmOSgq9A6xXI5cPV8ooCQ+8TNSLvNw7H9z9UF6b7qoa7Jl/ALhNxf4VChU7Yim0h5Q4nDoh8HA9Y4+3R5yr2R4CjIrNIKHkjNPhxf2DjZnt0UKkalWw3o3EWaSF6MYakxaj1OYQNaoKuBbOn/UugnIso7PQ4C0kC00oCWDnDtdiTMbgO3bdnxK3HDeLpI6A+0p0sWNOkhFOGUtXj0NCZvN75IH4oPwU9xqJQ/wv/VPQjrcr+vc6vsAt3qONngMsjzvyyo8AUwVU1+jbVhJ6V6oL57/JYw1FEFB4mb9QTU3Q9JsFRgMQfWvzLs6KC64it93CJjgfoQoCOYZ36E5ZlFQBLdDytBDhmYCERD6kXMZ0rTOVKXeotrGscNA+gakK8Uv2KK6klZM6iyImQQaLMzcpe4mjxHjcmq7mOWXITaWcn77rsqLSEHF+9fqfCetXvHOJvUBFYvfyORTDVBrlqGY03Kcvwaa3umvuux7NlXYw8ix0+6vw3zrC+H8MnhxXxW1c55KML6WoFIho9IQHEMCHwTuWTFGfus6ktLRM/z/Q4XFonIY7M4b8DyJR5Eypm8Of02Lu2VmZGakUXro/0Jlm+YQgAI/N8sFeR576n+U6vsmIhghl+4rJOBuRAdMm52oBpoSE5XCkAboNPFkH6MZeSCqZUmr19nYTTB2zDNKX9UEezIh/b9TqCtbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(186003)(26005)(921005)(122000001)(82960400001)(82950400001)(38100700002)(38070700005)(8936002)(5660300002)(52536014)(4326008)(66476007)(64756008)(66446008)(66556008)(8676002)(8990500004)(55016003)(2906002)(76116006)(66946007)(508600001)(7696005)(9686003)(6506007)(316002)(10290500003)(110136005)(54906003)(71200400001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1igmC/BZuBT1ADxV0rJjPGLfiwd9g/Np01k5TJilyrnjMZfMshikQvkp4NcK?=
 =?us-ascii?Q?KaECoHTVDLvkrEmA3PsWdv7UaSkweUG+AKWJSy99w61p/n936gIgxz2fFt8Y?=
 =?us-ascii?Q?Cs5n6htrD8BDEe8ycRH+yUSKFY6bm6VnGs/qR4a29f/7+N7aFEV9w+Gu9e2+?=
 =?us-ascii?Q?/je8EozKy8C7G1THi4FtpMkjCOU91DDjMUxzLcEG78SwDUp4lQmnZvPP08YG?=
 =?us-ascii?Q?pa0BTWvCJz0XoKNnZB/R80g+cqqazwvxXFj9TrtZMC5Ny25sGdQ6At8mQmZA?=
 =?us-ascii?Q?8DjKII4n2zPA2NrUlri7SG42qAJqsGjeRbFH7toOXiRpDbSMXa+10hHZnlni?=
 =?us-ascii?Q?hn57iNkL2SF1qwczV8dsA+m1FJ+9NTZl6N/j4k6SslGVaVmR1Q7FV0ZlGXdQ?=
 =?us-ascii?Q?eDjvJDuBMHrYOhLD0UymQwun8Qf2mEmjEMs9SHH+YpWdtRGQyTWO0zPkEx9q?=
 =?us-ascii?Q?9hLaPyH3GPYN6FOV1YvHlzQPT1dBfb6H8vQnSrwjGimRuuV4spGc2wo4jqrq?=
 =?us-ascii?Q?QHxcuowYSUjENjcdqWL+rOLjVava/msnHYxjUsv3uUGRynNrSNbbZBfSyqkn?=
 =?us-ascii?Q?/m1UhStYc5B4ngzBwyzpnbj4+oN26WpPSGXhG57yP0iOnhNei7OpqXmbEosj?=
 =?us-ascii?Q?IZmgb2mBeExTC8Eh6Hu5XAXus21KsI2uEm4d15cl5yZjSXeL5pRyw8Dg7VPk?=
 =?us-ascii?Q?a5VSsc2FRNhI71MOAsg1O/YXMzy25hOemugGpc5bUTCzcUW0OjAJjnYmaiID?=
 =?us-ascii?Q?4i29Bf43Kb9oFGcWZ9moj+x4dXJR/vAIlho0ecaCf7RsHfflbGDPMf6Bg3x9?=
 =?us-ascii?Q?72OeoeZb/paME8FMS0o71FAZr0cks3L0E5/9zbZKx9G7vth66T0uMx3SZZ0L?=
 =?us-ascii?Q?P001Do9odXE7LscW+B2V6nSkRWUAZTV8+CcDaSKABu2VYW5k3h5ePmIV0/sw?=
 =?us-ascii?Q?4Qbsd6sGuqLn5aOV7EiHBmNQ9pytIMErhFpqh1Yt7ajKqfD6hjK05VnY6ZfF?=
 =?us-ascii?Q?35u3knOx/pS5f/rINK+UQ5utfSKwQrG/+fPrH5iiVorIyB9NpBBu++8t3IMh?=
 =?us-ascii?Q?gtyNxS9dmTnZpHsMUof7odcJ/vQXTwVcQg6ckt97B6s2Xy92EeAYeQ+YgV7W?=
 =?us-ascii?Q?o5xmzCZW+Gq05xXhXf1sBL2i61I0dtZCF9RWGxcK49ldIPPqNlG+l5fOXk/d?=
 =?us-ascii?Q?glMo0dd4IL3XwnT67rzeTZnmFJjbZ6YzqOp8i5Ie9D08jUFyYaxG/47CNdPw?=
 =?us-ascii?Q?Dqz6Ko62ykOULAxTI716VHwFMfB0okt4OdJS8ygm8XDUeuXU9thJO4haZ4h3?=
 =?us-ascii?Q?RCJIyOviQMmwoz8xVsTgHnXmsRUnttJy/DCB0J2xckc9K8uwjafpAviTRQ6V?=
 =?us-ascii?Q?kxVCSMYYjRM0Hvn3Nc/7qllKw028JfCpfL1/Bhv8ZJTQMQEqXIUsaVPr08iy?=
 =?us-ascii?Q?ikfEo4qWLc+YX6olxAvdwaojfF+UbpCHQCl3pGi7nNjk8RGw4IdSxxue8KpT?=
 =?us-ascii?Q?m782Cu2PP5/5bgdKISCihUe2Z6dt8hoG3gLqpKGr846kBwMUtiDU+DgZuf3h?=
 =?us-ascii?Q?lWF9Ssj5nd33eI4XmTL2+5Jpo2v6U3zZfUJA7NnUw1gzl9IZG4sXh71K+8dJ?=
 =?us-ascii?Q?/RpLvcB9F2BapHnOZNk+dM2TXI2szipfsYVWybkQ7fm5iK6JyiEtX/oaOjT3?=
 =?us-ascii?Q?QhRMTzMfMdZDKi77sFYyfZDA+v4xjMTjFkSu88W3LQufBPmahuWwYjE09oJE?=
 =?us-ascii?Q?/yV4Zk/RTOmLANv2HKckmrwMM/YouIQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4916c71e-bf06-4630-bccb-08da221a7fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 15:37:23.3931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHnqdLDevJcRJWfL4Uv/Y7VcolzR8ZRha31u2Opw8qHu75gciB9ea5zPPN94YFEaXMz/VpZzPaHuYeI8ShiwoLioCeJXkUntjHrl/IhqKUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1285
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Apri=
l 19, 2022 5:23 AM
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

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

