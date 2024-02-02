Return-Path: <linux-hyperv+bounces-1506-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B38476ED
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Feb 2024 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594AC1C26AF2
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Feb 2024 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5B14C590;
	Fri,  2 Feb 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="B5Xs7c+8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11022011.outbound.protection.outlook.com [52.101.51.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997414C586;
	Fri,  2 Feb 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896899; cv=fail; b=eb2bt9B32xGu53c+TwOWzUhirHfcuVXQhJdWJK/VD8hguw0kNq9hR8lWbmildYNt1Rd0dBBmt7bN1Wp303MT/SaWRu748Zv7ajATNUrXZi8a7ZDbcNhmLOn5D/8SwE5t8nWCZ/xhxrYx/4Mw03ks/1XYopCKt154TgYFKHdBh38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896899; c=relaxed/simple;
	bh=vgDMgFf4CCrkaJ7USrgRAFTHKe5xeYSY3hRaZ1fBm+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UJ1SQKOCpfJPK99zshu6J5douDfKijaowTJFdItcDwNXMHcMhVYHE3odyDeGsOiaXqVTddGiLuwCm9QzDkCZU7nueOMce4Qk6RFBi5It65eRLzOhvLszdw2oMpstFageJ/EkD2uZlCL5lYKVZCVJ2nd8Lo4IyRK0xwZkYCStOFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=B5Xs7c+8; arc=fail smtp.client-ip=52.101.51.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU0bLM6L9HuMlTglI+fK71gEmMMYod9fQ2aHBiQ/O4ky2DiGBiPPO9I/hlrsUxQhgg7VP4LhxqmMPP1nskvVr1ao8fQkPVOI07sn8s/GhfYTt/KLfvviGpaPz9MP6/qzWqenzaVNDKCTbwr6eTmgvA7EA6EZbmBU5g1DwFPbimRwzDsjkQVL3bv8Tr2yYRJiYdB1A3xDtnUUiKkdfWyA+HinJouK0y4zra7x1gmlw3i03s/ERR+/3Ol/oaSUNCM54fxxCu4+pG6CyW/cwrkJ6zQDYO2TSrEk7E+WWtJLO1I8TJSwaAzcQQBz7Hv+cZJ9+iJfYBO7hY2IDzXQn/pkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMslLMjDfopZZsliWyjPa5RXlh4Fo6w9IqBYIHsJJ6c=;
 b=eKs7DZYD0m1WQFlLSozh8ynKfHdI7+PTFlp5DlJJL6g3UHqQO2kN0WhHjy0egjVJilCt5vPR39yAnVYsTO1BIx/yxVnMqJuhhjQo+AWs/AHPJSqQbS20Gfs5NRVzxg247vvliVIXbU58A2HZGe/4UTKiqjMZ437xypN3qwoAZil3foCIUXC60LGJJz+Ypn8RtRvj3t0aOR+DEe+H87qM1xy6f2TSLDxClI5KeIUNZ9kZBw4ZrpZI3KKOzbs4r16r43WlKD2q9a7z3klvHzESuySTY2fwtgI89oa2dq2Fb8G4OckUs8UmdJHTE1s1Pi3FCbE1vBjeDXZd3J9VZDzv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMslLMjDfopZZsliWyjPa5RXlh4Fo6w9IqBYIHsJJ6c=;
 b=B5Xs7c+8livlpAJQvLwrWRoMkG3UbGTPcT4V3I2yGtDDAjh/erYYcgoc0jN0GuZliogCeCLpOaSE0sCBtcFYJR/S/aUs7dvGXG8R3HlfHYKPCjXCArpwI2jo1kuHiEn4AapFQRmyWqQBwuLQAFYn03mGK6kf4nkFdQgceL3MdIU=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SA3PR21MB3890.namprd21.prod.outlook.com (2603:10b6:806:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Fri, 2 Feb
 2024 18:01:34 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::e70e:b956:2c00:5c5d]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::e70e:b956:2c00:5c5d%5]) with mapi id 15.20.7270.012; Fri, 2 Feb 2024
 18:01:34 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Shradha Gupta <shradhagupta@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v2] hv_netvsc: Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [PATCH net,v2] hv_netvsc: Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaVgHa8Aq7GzItAkCf93JhWU11/Q==
Date: Fri, 2 Feb 2024 18:01:34 +0000
Message-ID:
 <SA1PR21MB1335DB04BD32FC32784898F7BF422@SA1PR21MB1335.namprd21.prod.outlook.com>
References:
 <1706848838-24848-1-git-send-email-shradhagupta@linux.microsoft.com>
 <DS1PEPF00012A5F37D341C0E2B95E6A22E8CA422@DS1PEPF00012A5F.namprd21.prod.outlook.com>
In-Reply-To:
 <DS1PEPF00012A5F37D341C0E2B95E6A22E8CA422@DS1PEPF00012A5F.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=247e505e-131e-47e6-b3b1-ebf3b19c0afd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-02T17:08:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SA3PR21MB3890:EE_
x-ms-office365-filtering-correlation-id: 152192ef-b545-4019-94f1-08dc2418fe4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2x8HG0pZAIUPBsWEK0miohH1MiXLsWUyCmy56I1Usf/iZglKquUH6ek1FRf9zTjHYEaUeqnj7ScK0/RlQFrI5BUMNe9fojLLIrgee6PkLnlViO/tV5Tn3AwVMDjRLSSTbnyqpweJ9WaR8DrjcsThZq6JJ7D0L5IPMLZFDdrbCk3oUp5zKeMje/8t0RhW9A/rIOy9TAw2209c09WNeg+9QjbwSmJL5cyQNa9WarRMnDRPxaCXb37JeJXqmCCeBNjEJve3Giop1bjmxyOfi1SPNLgncAZYUuCUEK2R6AsCLG5HRjzJVrM2LI2i5LbkJUU2EWiK6gve3YETddHfrD2VVTiNJQlwEFkDqWPR7hBxTklGNQOc8SQz3uXa+bVTqAdVs+DTay8QgMREmHFKSphv03ycyqzRd5BsKVy9W68nTaTdeC5DjHuEGLiuu5QO95dejDnv15LM2h9piMIACLMM3gDqOZjlsqgx1G0UcOPS10QCP4397wlWihOm3/SKgtYUNgsQmmFqpsA/OWDPX73eOY5R6eFF9MXiIHanUwF74g9aPU5mws/ldcNjDqoHT6lI4idVAayqtODO2/e6vrq3uw3N+LZTHqo7E65gwg43WWhbiwk8Z82fGKbps1+vhhWb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(41300700001)(33656002)(558084003)(82950400001)(921011)(86362001)(82960400001)(38070700009)(26005)(122000001)(38100700002)(8676002)(9686003)(54906003)(7696005)(66476007)(478600001)(10290500003)(6506007)(2906002)(110136005)(316002)(64756008)(66446008)(66556008)(71200400001)(8936002)(66946007)(76116006)(8990500004)(4326008)(52536014)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1rzR0a5rxpLDrtj4LEbQaSrW5K4E9QxajOXjUFGEk0cR7OgLdRO/YFC7nUUx?=
 =?us-ascii?Q?RrIRdAUDLMjTTX98JOLG2mqLX9eMNTNtWbAKfhjavcNR+v8ayZ8ghPubVg6k?=
 =?us-ascii?Q?dzg0R/nMROGG6uNyKYbgukePk0ObEpkj9llrZsxJFfTMGJ15wPmTZiANEnya?=
 =?us-ascii?Q?Wu5u6UpcTofOHZpLsUCkytz0CVxTgUJzr7ZHLgW5ETQT0aqtHvwvUk70BIua?=
 =?us-ascii?Q?sg/eJRRJZaplotE31aaDOmf6PRk3ORNGQ/nEWe4u3Nz5v4egnBWQc7pOzOzR?=
 =?us-ascii?Q?dmQhsCTOPbwrkaGPeFlUJDXKDcocNpO6lq/DM6WWL5pEkCVD88WGrtK2NSd2?=
 =?us-ascii?Q?GP/bnI8DFPwT3y0gmBzLGD6/S0Q9FSSanuarm283BM2D8+AP75uR0R/jeR+h?=
 =?us-ascii?Q?ekq08F21FFFvFyu6SX8rnbw3H4kCsM/AQ9WWSWLjqn0WjPOKeC9L13RkTzla?=
 =?us-ascii?Q?N2PQmWCzc/p5MwiL03x0wE9DpsfHyHusv2ASunZKRjMWEaqCsvGCgq+LZeKB?=
 =?us-ascii?Q?wV49W4kjNmAF5HBYIXVgZuKlDKArtOZY1V+3YieeWEzH2lsBS2BmWOHFtX/s?=
 =?us-ascii?Q?f6zowV9Omfka9ttYAWx1abvPXVyAw8HGzgauvuSO85pZd/2fVn6UuiyE5Wsh?=
 =?us-ascii?Q?s0FtXiziBjyRxyA9NLLD3+0PBrbtZ6A8p37tMiexASQCDhTkcHRxmstNXgqA?=
 =?us-ascii?Q?bwaCtQ+88R2XyUUCpLII3oKf/mxogmS9ioIJAC9apNvRSIzZMTEcGvgPo6UI?=
 =?us-ascii?Q?HcNqM+oIRfGXGWExW6UPN9i4D4EjxZnGH2NUZRi8+VShmvsxcbOeXTOTCdwF?=
 =?us-ascii?Q?YEhkmeyE/YTnmwMIeMTa0GCrk9sOQ7YPuuHqzOrrrpyL2rZSAIjKydqF4MGM?=
 =?us-ascii?Q?gaE3GvtjoQgNoMy6ov0+robIOMc9RU96q1SgrkTqtJtHRzSlPVmg6mdDAg+1?=
 =?us-ascii?Q?FUGrTYYvOBDfSmo/VJIAEwFpKI64r38jT2Bq2NETuOmBgtEuGEzvnXmXGqwc?=
 =?us-ascii?Q?pZAAg6rILB2oKnCoAkJ1x8zTl+Qx3RGIunii5fkjaMR3H7k5OaxNHysEovcx?=
 =?us-ascii?Q?PQwRu+yScdh3Lo6b0pS2hUsBHu/Gqhq6LXsU3FELFsqYeqtlBPbId/tExuWQ?=
 =?us-ascii?Q?EEkEcNC7HdLI6TPnCIN2EYLdhnSazEGCXHUA6fw76czib11LjrH/plrAzyIZ?=
 =?us-ascii?Q?VqL1c5Ia4Sw7T+tbIdPpt0kRymFqKIDb3wy1KEaQE+h9/TmI9cYo7fQ59kvN?=
 =?us-ascii?Q?uvpbmL1DXJ8ApmgQnDF1GDikUU+/ZIw4aadFWTMgbmEltljq/jxU/YpXnuIQ?=
 =?us-ascii?Q?HF52/ivU1PbGE103nH7lGVEgonYbJHb5u9Jwkm4sVW11FHOy763XHgnCYrBi?=
 =?us-ascii?Q?RScwlKZQXlCXXARDaNW0cNlhwcbxs0VwGWVKR3HiN45AanxGHN6IArWBZlCz?=
 =?us-ascii?Q?tmC+0WO14csz0ydshWqJliCF4cBvrDLU5R/xDGgZ8PDsg9YBCfn+PbXH2PyA?=
 =?us-ascii?Q?gLHqpx5WMC3p1lALOWyw7fczGeLRTIp1LYU0zVBFPUJH8kEs54cs1nXPwoSY?=
 =?us-ascii?Q?Jw1Q8YlOTvr28T7XbuAqDQ66NPfwwEIETuq/YNSW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152192ef-b545-4019-94f1-08dc2418fe4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 18:01:34.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIoePMqW6gRfF4uFj1A/IhrTYNxx+n7nO4/3zV3EEf1wcew0GxaYFC0yBHKOXaJbDJ/9fUxUgR+qfDk28xWO1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3890

> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Friday, February 2, 2024 9:10 AM
>  [...]
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>

