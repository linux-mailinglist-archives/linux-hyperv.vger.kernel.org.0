Return-Path: <linux-hyperv+bounces-9015-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLrzCb2eoGlVlAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9015-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 20:27:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE01AE54E
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 20:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C51030B046C
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 19:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1044D008;
	Thu, 26 Feb 2026 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FSOTnU7Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020116.outbound.protection.outlook.com [52.101.85.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B744A706;
	Thu, 26 Feb 2026 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133759; cv=fail; b=cpR+kifGQaf67alVpeYH+39H31hwMMc0M94FfklMg6uFEtW+ff0mKpswYhJG/a1Xc8u8osyiucUP2YO/uxqlx9aEk+GSdqVxfXjou1K0om0v+qPYXo1OcLvPtiDj8RSblZHcfccdLbnBFEzaDU57RjDw9Zv5Gk1YBCKGDfru7E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133759; c=relaxed/simple;
	bh=9F/dkWnALOGjp7vNMWEnN0K+c6ANiF8CxA0+t09vxYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ecj59vQ/SUi1Ns8WmEmBDFnGwbg4KVcTgSlMb/ITU2mKrYznAGVTFSXwoVZtAYL6haKEy5i0zoBFxG4X2W+ZqcwGQMGaq47VRU1ZWwZtZOQl7g+ANIxzu/Qbr+W5VrRFtxxrK6Td76Bc7KYoKD0NGv6z4I3qy0f+WyuIUOkonLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=FSOTnU7Q; arc=fail smtp.client-ip=52.101.85.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5ty7PaSLI3/ZhUzeP7O7GuCDsiOn3a3g17q2IwN41CIpyybxnvZjGoWflDXPpkThNyYiAFh/SdxUzn9sx/hTEVzcRhqDwnFVoQ1ZRI+wd4shxixSqjf+XBZLO/CsQu4C48rBSyWY1WsXKxRNtpeLjxNjjZ6kmz2j8RbaZKp8NIJ7a7CVh+3QAG5A+vnA/sP3OlZsFHH9oLrJNspt+QBI5MXvO1VAwE0ysN6b9HYVumFLQn19HZzeQ5NI7h+dKpxFGpD64epgc8F5Si6gVA+MHYNbCPTq+SgN1EbXoPxuSO07PszNFH1kS/F28jL9JjE61rZGPhaaOQ/srByDDmWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F/dkWnALOGjp7vNMWEnN0K+c6ANiF8CxA0+t09vxYs=;
 b=CE4qhHb1IP+0QIV7lJ29TRp9Cxo1Bme28/kyMFCSIzQZ4MbQfi6gBJjCurXL5k+5yFgHCZ61Yk0ubS0EonwIEoI3keSR+0lgIxQnJEeOMSak0jk3AGekslXAUywA5nUB09YGlGP73/QP/rg20S/spbSPOI5MhluXzRIhHZUkbtlU/e4rdwkVAyXqXJHVBBhiq1/ds5fdOO9m6ZfFCix3RrGXTmEmyUdGMh3rlFJrrLKxb6+rU0dDKmbUrkJ28byQDYJSrqr1BvO8GkGpazFVYWsK32Z+DpkA1wEBfBcbaF5Q6nQAhRuEfMMzW1/BenpkA05o+IMTXjDz1esnPwtQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F/dkWnALOGjp7vNMWEnN0K+c6ANiF8CxA0+t09vxYs=;
 b=FSOTnU7QqyKzA0Te4t3t4b8+aAwiXSa323yUvU4M8kIB0WEq7X12my+FI3r/ufgR5HfPTF0CPz73tC45nsxOTvjb02lpdJlIS+eS7Tmfkp+qvmt74IScfU2cqihtRjvokkl8QeGOHVHQaHzjpz5tXlLNBpiXLy3OUpv0dWan0D0=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS3PR21MB5732.namprd21.prod.outlook.com (2603:10b6:8:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.8; Thu, 26 Feb
 2026 19:22:32 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 19:22:32 +0000
From: Long Li <longli@microsoft.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Shradha Gupta <shradhagupta@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net] net: mana: Ring doorbell at 4 CQ
 wraparounds
Thread-Topic: [EXTERNAL] Re: [PATCH net] net: mana: Ring doorbell at 4 CQ
 wraparounds
Thread-Index: AQHcpoeTOzqGPwCatUy3u/M4+n6mUbWVCzkAgABSHdA=
Date: Thu, 26 Feb 2026 19:22:32 +0000
Message-ID:
 <DS3PR21MB57353F681B55397543B2FD5ECE72A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260225184948.941599-1-longli@microsoft.com>
 <46896339-b3a3-4109-a2e2-324446be5aeb@linux.dev>
In-Reply-To: <46896339-b3a3-4109-a2e2-324446be5aeb@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=372703ef-dc6e-4a35-9806-3acfcf4f6040;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-26T19:22:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS3PR21MB5732:EE_
x-ms-office365-filtering-correlation-id: 97646c99-9e96-462d-35ca-08de756c63ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 WbcTLK86IwHEhPV5pHzCMtM71CNTiPXj9dL5YNRPDefj0dNFHH572xEPd3bAweyagpWYJJjJaWrf3A1/MKouWJF4BuuS9yZ0EuvuekEj+sO+IZFZfQohMS9YhOTjoX1T/gCPUZwMVwM98+hpwxQYzVSfRzujlspsDQ5xdHevwBWjLjDHzBjccSmEVbPbJY1Sh0/G/li900Pt2W/rG9Ge5xdEA5XuoxXM4XuWw5TPa6gKOSBx3GqZiIwTfDHQ5c78cv64mcmX+SilhLOVGeGOm14Yq5uyQDIgyl7Pn1/wFJ3oLWX0L85vP8uOGRH3fUvICnOVX/ja+lCpc3+/0SRZZid9DDO3F1I0FdwAGg/Y84CeDLt82gF5SQ5fbxZMzJsPxSBn5EgaWwR/agZA+1DEJ5342NdV4/mlGYr2Z6yRHNL63nf4jSupJpAreXnQTG9uv0sNqhhl/cntS8mWeunQ1Gt3RajXtCpz0KReGBA+MMPhaX1YFgPI3z0qqkxzTe3/MX8qoFDAUFWdODFvMD0DXVmgKA5+rqixsAyY14WNVIAqUP5SaQO942thoc2fgLo/nXdv2J2TeOAlHcslYFR3kGIKA972/gCHK/G9aUosSBo8SgbI+5GbfwLSBc1c5xy5WdFI91qVFEjjQpJCSNQfUefgEgpwggz2pYSHg0gpnnLQCMvJ+dCztQTMOLtXW7MjZIqbJttATcrIQMNTpjPmVxi+v6Wk0b+//Hxd7GIdR1f+gC42stjNFWx/1VIRt3sXcm811lYYxVMlQSSmp6Mg5jHZTHFWO7L+QpCswHcDQcEPOVn/RylRw7S86xaUTIBk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTFHdC9aWEI1cFBoN2FuUzZ1OFE0MjRhTUJiWk5vR2dpQlczUWZlL3FqUlRk?=
 =?utf-8?B?VDMrYVFGeXR6UXJyVGc5ekd2OTBVSjhvOGtaeWhBbDZkSkxkS1FzUTZxM3l0?=
 =?utf-8?B?QWZRcUtZRCs1dzR3VTFUSjVPZ0pJaC9wcXN2cmFodEEyajljWUUxRkdkWE4z?=
 =?utf-8?B?RGhaM3hLYklSS0Yyd2VDV1ZHVjkvV3p4YjhkbEZOSVk1MHhESDBFVEM4aTlK?=
 =?utf-8?B?WWpML3dWWjJiQlYydTVDY3h6QXBLWjJiWmlqZ2xSUElzbWxNcHFROXRpcFE2?=
 =?utf-8?B?dThVaGkwaTNvS01Hc0JTREh0bU01aUQvQitKNEVqSVh6REZpQUM4eXpFaE5K?=
 =?utf-8?B?NVFQNVlqUmVWUXdMZkNRbUJPRy9lOXVDcXlRK0tJNXh3aHdlOUVNSHNJSVlX?=
 =?utf-8?B?UXhiaThTZ1VWVktRc3VLSXlPSFlReEV0ZG1KWnMwNi9JVGhyU1ZkemN0QldS?=
 =?utf-8?B?cVVPM1pqaEZuVUlrcXMvVGV5bVVvazJudHEvNVZtem5SK25sMnBRbWkwL1NJ?=
 =?utf-8?B?K0NPRDNJM0VtT054NWJUcXlvdWtUUU81OW03OUMrMHpJc0tzYzlMR2Zkc1RL?=
 =?utf-8?B?L3c3dWs1SzYzaWlyb1R0MmlwOUdwWU1mZVJBZVVPV01veFluQ202R09BKzc5?=
 =?utf-8?B?cDdQeUVkSlNSQm1RdWRYdy9UMk0wYzh1dUdhYkg4VGhmOTFUR0lOdkpMZ0xI?=
 =?utf-8?B?TGErZHZ4dEpteEpwYnRFVEM4UkU2bEM3Um0wcW9qWkJHYmlGV3JYUmJZRXdo?=
 =?utf-8?B?RUlaNHBpdjk4WSt3TzRZS2tCdXNFeGlhNzBwTDBicE5Ea3B0aFRMY3k5MzRi?=
 =?utf-8?B?blIvR2FlTWc1ZWtWTXU5SXJZSEw4a1ZiMFRnWlpnVnFCRml0clRsM1JUY2Rs?=
 =?utf-8?B?dnFjL3ZuOHFsTkwyd0dCenl4SHhtWEZiZjNNY2VQOE9zTysrZnZ1MXY3MG84?=
 =?utf-8?B?OWFJenVYeTk1S3k3TEcydnVmT0UwbDZDZ3Y0dTJhR1RWUEVZMVRROHk0OFQv?=
 =?utf-8?B?aHkyT203UkwrWFgzRXRFbkw0MnoxMHpXSjczSlVwbGc1M0VQTElKUkRIKzF1?=
 =?utf-8?B?OEQvcU9McldINGYyVCtNc1ZHSWRUS0ZlKzdtQ0wxalFsL3gwd3hCbTVmSlE3?=
 =?utf-8?B?c1ZqbVl4ZktJeC9oc0VaTExaS2RBWUxIQVBrc3psMnl3UmpHaEVOM09oMWUy?=
 =?utf-8?B?a3pSVGlEaHhtR0E0UDlrSXpkZjFJNmU1RUhZUnRsazk5SnpzRDZYcDQ0ZFBp?=
 =?utf-8?B?ZFJqQ0ZsRDI4WlVPZzJjVGJTSHVzazQzaGZTZSt4dld6OXNmY1g4YUQ0Y2l3?=
 =?utf-8?B?MmR1L2htUCttYnY4VGRYcXdnbDc3VzV5R3M0blBJQnJVbjcxcTNWK3N0K1hr?=
 =?utf-8?B?bzl6ZWE1YldGMSs5RVQybW52eHBSbnIvbDZ3WDhpb1BIMzJVQlNoWEE1ZjU5?=
 =?utf-8?B?YVpwYXNOd2ZCNFdtZXRienE2VStzSEdlTFU3UFl2dnBrd0czVHBkWjRiZkVy?=
 =?utf-8?B?dmNFZEFHbnlhSFpFdGJySWczaVg1U3RYRjZCOEVON3Q2eHFjSkxvTG1kdktr?=
 =?utf-8?B?QU5YNVppcUFiUnBxM3VDRUNYbWxuVmdGUXRBdVZXQnhhMHd6WVpyeDkzYUFS?=
 =?utf-8?B?RWo2VjVtbXBFZ0wxRFA4RVpyUXhXbUdScWVpaDQ2NWNiWFZhNWowMmdLMTZO?=
 =?utf-8?B?cHYrSkp6TkZtZ0gvWEJCaWNkNlFQYk45NVl2N3lKZlZwMEltWVhMTHZGN2Zy?=
 =?utf-8?B?TlNhZVNzT09LUDljcFNWYUg1RGRJK3RnTGxaYzBGcHJIY2xVeEhKK3VETFdU?=
 =?utf-8?B?czR3U1NXUlNKQ2ZhZ3Y0cEQ5TVBMTHh3eDZTaVpMeVlnRDIyWjh2UzF0VjZL?=
 =?utf-8?B?cUFwTXJYZVlMWWg0SWJyMFg4ejZjbXAzU2F0QlM2cGlCN0p1T1BnYUI4UThR?=
 =?utf-8?B?NURiMnN5S0pkRFBGRWhSWitGZzBoRnBkallYQlYyWElTNlVzNWphTlo2Rzdn?=
 =?utf-8?B?a0VXTE50Y1VkMW9Yb29WZlZIYW1PeU9DRlpibWozZDFyc0U3TXJRK1VsN2Fs?=
 =?utf-8?B?Tm95NUJyRTJ2TXpBZlRNUTRBMkRtRnVveEtrQzJMT01HMWoxUzJuaEsxYzEz?=
 =?utf-8?B?bVFRQ1E2bW9XUmVNNnhHcENmcEltUGRxdVU1d3hvVzROcXk1MDlxcFJPSjJs?=
 =?utf-8?B?YlMyQ1dOL3BtVjl3Vmw3c2ZxWjFpVFZLeXhMeHd0U0lWWHFSZVBqcjl4MWNK?=
 =?utf-8?B?Mjd5MzVEVW5VQzc1OVJMOXZwVU9wTkFOeDN3NXlQK0FDaXZiaVdhRzRNeHAr?=
 =?utf-8?Q?K7eu2GixezUHxEEeV7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97646c99-9e96-462d-35ca-08de756c63ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 19:22:32.4111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csVQ8KfEruE7zGub6J8V6T2IoSfq/9sL9b1LBIIMsK81f2byaSIpLdWoC8BJ2RJyyEhlKugy8GudY2v9q9XRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR21MB5732
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9015-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0EE01AE54E
X-Rspamd-Action: no action

PiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggbmV0XSBuZXQ6IG1hbmE6IFJpbmcgZG9v
cmJlbGwgYXQgNCBDUQ0KPiB3cmFwYXJvdW5kcw0KPiANCj4gT24gMjUvMDIvMjAyNiAxODo0OSwg
TG9uZyBMaSB3cm90ZToNCj4gPiBNQU5BIGhhcmR3YXJlIHJlcXVpcmVzIGF0IGxlYXN0IG9uZSBk
b29yYmVsbCByaW5nIGV2ZXJ5IDggd3JhcGFyb3VuZHMNCj4gPiBvZiB0aGUgQ1EuIFRoZSBkcml2
ZXIgcmluZ3MgdGhlIGRvb3JiZWxsIGFzIGEgZm9ybSBvZiBmbG93IGNvbnRyb2wgdG8NCj4gPiBp
bmZvcm0gaGFyZHdhcmUgdGhhdCBDUUVzIGhhdmUgYmVlbiBjb25zdW1lZC4NCj4gPg0KPiA+IFRo
ZSBOQVBJIHBvbGwgZnVuY3Rpb25zIG1hbmFfcG9sbF90eF9jcSgpIGFuZCBtYW5hX3BvbGxfcnhf
Y3EoKSBjYW4NCj4gPiBwb2xsIHVwIHRvIENRRV9QT0xMSU5HX0JVRkZFUiAoNTEyKSBjb21wbGV0
aW9ucyBwZXIgY2FsbC4gSWYgdGhlIENRDQo+ID4gaGFzIGZld2VyIHRoYW4gNTEyIGVudHJpZXMs
IGEgc2luZ2xlIHBvbGwgY2FsbCBjYW4gcHJvY2VzcyBtb3JlIHRoYW4NCj4gPiA0IHdyYXBhcm91
bmRzIHdpdGhvdXQgcmluZ2luZyB0aGUgZG9vcmJlbGwuIFRoZSBkb29yYmVsbCB0aHJlc2hvbGQN
Cj4gPiBjaGVjayBhbHNvIHVzZXMgIj4iIGluc3RlYWQgb2YgIj49IiwgZGVsYXlpbmcgdGhlIHJp
bmcgYnkgb25lIGV4dHJhDQo+ID4gQ1FFIGJleW9uZCA0IHdyYXBhcm91bmRzLiBDb21iaW5lZCwg
dGhlc2UgaXNzdWVzIGNhbiBjYXVzZSB0aGUgZHJpdmVyDQo+ID4gdG8gZXhjZWVkIHRoZSA4LXdy
YXBhcm91bmQgaGFyZHdhcmUgbGltaXQsIGxlYWRpbmcgdG8gbWlzc2VkDQo+ID4gY29tcGxldGlv
bnMgYW5kIHN0YWxsZWQgcXVldWVzLg0KPiA+DQo+ID4gRml4IHRoaXMgYnkgY2FwcGluZyB0aGUg
bnVtYmVyIG9mIENRRXMgcG9sbGVkIHBlciBjYWxsIHRvIDQNCj4gPiB3cmFwYXJvdW5kcyBvZiB0
aGUgQ1EgaW4gYm90aCBUWCBhbmQgUlggcGF0aHMuIEFsc28gY2hhbmdlIHRoZQ0KPiA+IGRvb3Ji
ZWxsIHRocmVzaG9sZCBmcm9tICI+IiB0byAiPj0iIHNvIHRoZSBkb29yYmVsbCBpcyBydW5nIGFz
IHNvb24gYXMNCj4gPiA0IHdyYXBhcm91bmRzIGFyZSByZWFjaGVkLg0KPiA+DQo+ID4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBGaXhlczogNThhNjM3MjljOTU3ICgibmV0OiBtYW5h
OiBGaXggZG9vcmJlbGwgb3V0IG9mIG9yZGVyIHZpb2xhdGlvbg0KPiA+IGFuZCBhdm9pZCB1bm5l
Y2Vzc2FyeSBkb29yYmVsbCByaW5ncyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTG9uZyBMaSA8bG9u
Z2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9t
aWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMgfCAyMyArKysrKysrKysrKysrKystLS0tDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2Vu
LmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFfZW4uYw0K
PiA+IGluZGV4IDk5MTkxODNhZDM5ZS4uZmU2NjdlMGQ5MzBkIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFfZW4uYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFfZW4uYw0KPiA+IEBAIC0xNzcw
LDggKzE3NzAsMTQgQEAgc3RhdGljIHZvaWQgbWFuYV9wb2xsX3R4X2NxKHN0cnVjdCBtYW5hX2Nx
ICpjcSkNCj4gPiAgIAluZGV2ID0gdHhxLT5uZGV2Ow0KPiA+ICAgCWFwYyA9IG5ldGRldl9wcml2
KG5kZXYpOw0KPiA+DQo+ID4gKwkvKiBMaW1pdCBDUUVzIHBvbGxlZCB0byA0IHdyYXBhcm91bmRz
IG9mIHRoZSBDUSB0byBlbnN1cmUgdGhlDQo+ID4gKwkgKiBkb29yYmVsbCBjYW4gYmUgcnVuZyBp
biB0aW1lIGZvciB0aGUgaGFyZHdhcmUncyByZXF1aXJlbWVudA0KPiA+ICsJICogb2YgYXQgbGVh
c3Qgb25lIGRvb3JiZWxsIHJpbmcgZXZlcnkgOCB3cmFwYXJvdW5kcy4NCj4gPiArCSAqLw0KPiA+
ICAgCWNvbXBfcmVhZCA9IG1hbmFfZ2RfcG9sbF9jcShjcS0+Z2RtYV9jcSwgY29tcGxldGlvbnMs
DQo+ID4gLQkJCQkgICAgQ1FFX1BPTExJTkdfQlVGRkVSKTsNCj4gPiArCQkJCSAgICBtaW5fdCh1
MzIsIChjcS0+Z2RtYV9jcS0+cXVldWVfc2l6ZSAvDQo+IA0KPiBubyBuZWVkIGZvciBtaW5fdCwg
c2ltcGxlIG1pbigpIGNhbiBiZSB1c2VkLCBxdWV1ZV9zaXplIGlzIGFscmVhZHkgdTMyDQoNClRo
YW5rIHlvdSwgSSdtIHNlbmRpbmcgdjIuDQoNCkxvbmcNCg0KPiANCj4gPiArCQkJCQkgICBDT01Q
X0VOVFJZX1NJWkUpICogNCwNCj4gPiArCQkJCQkgIENRRV9QT0xMSU5HX0JVRkZFUikpOw0KPiA+
DQo+ID4gICAJaWYgKGNvbXBfcmVhZCA8IDEpDQo+ID4gICAJCXJldHVybjsNCj4gPiBAQCAtMjE1
Niw3ICsyMTYyLDE0IEBAIHN0YXRpYyB2b2lkIG1hbmFfcG9sbF9yeF9jcShzdHJ1Y3QgbWFuYV9j
cSAqY3EpDQo+ID4gICAJc3RydWN0IG1hbmFfcnhxICpyeHEgPSBjcS0+cnhxOw0KPiA+ICAgCWlu
dCBjb21wX3JlYWQsIGk7DQo+ID4NCj4gPiAtCWNvbXBfcmVhZCA9IG1hbmFfZ2RfcG9sbF9jcShj
cS0+Z2RtYV9jcSwgY29tcCwNCj4gQ1FFX1BPTExJTkdfQlVGRkVSKTsNCj4gPiArCS8qIExpbWl0
IENRRXMgcG9sbGVkIHRvIDQgd3JhcGFyb3VuZHMgb2YgdGhlIENRIHRvIGVuc3VyZSB0aGUNCj4g
PiArCSAqIGRvb3JiZWxsIGNhbiBiZSBydW5nIGluIHRpbWUgZm9yIHRoZSBoYXJkd2FyZSdzIHJl
cXVpcmVtZW50DQo+ID4gKwkgKiBvZiBhdCBsZWFzdCBvbmUgZG9vcmJlbGwgcmluZyBldmVyeSA4
IHdyYXBhcm91bmRzLg0KPiA+ICsJICovDQo+ID4gKwljb21wX3JlYWQgPSBtYW5hX2dkX3BvbGxf
Y3EoY3EtPmdkbWFfY3EsIGNvbXAsDQo+ID4gKwkJCQkgICAgbWluX3QodTMyLCAoY3EtPmdkbWFf
Y3EtPnF1ZXVlX3NpemUgLw0KPiANCj4gc2FtZSBoZXJlDQo+IA0KPiA+ICsJCQkJCSAgIENPTVBf
RU5UUllfU0laRSkgKiA0LA0KPiA+ICsJCQkJCSAgQ1FFX1BPTExJTkdfQlVGRkVSKSk7DQo+ID4g
ICAJV0FSTl9PTl9PTkNFKGNvbXBfcmVhZCA+IENRRV9QT0xMSU5HX0JVRkZFUik7DQo+ID4NCj4g
PiAgIAlyeHEtPnhkcF9mbHVzaCA9IGZhbHNlOw0K

