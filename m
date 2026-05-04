Return-Path: <linux-hyperv+bounces-10618-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id V+38Ewkc+WkX5wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10618-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 00:22:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBC84C459F
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 00:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3429E3016D36
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 22:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7737FF6A;
	Mon,  4 May 2026 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PUbHg+Jy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023128.outbound.protection.outlook.com [40.107.201.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975037BE78;
	Mon,  4 May 2026 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933316; cv=fail; b=muK/7WBuC220UZhYRN+xu1p+GOxrFeLcXdOc2Q17AotK1nr3M3dekQabi/SIRK86s1WeePb577YK7REt1AKZ6scZR4E15RhUEFhQAUin2d5eU3eC3BkzBXaszmpah8yxEVorD6ByMtNVzMqmc0K8Z/JZr/FmNwSSU2u6kbqDhlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933316; c=relaxed/simple;
	bh=KUp6va3dJBUiO1XNMAO/Acj5Ox6UKWrZRcyD6GFApno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fH0qPZbtvghc0ct+EeIAz+Gs9bzpGNaFmEZkRcSsxiS4oyUob0mec1OKf5OXElzjWsFmAIzS5qyQy/w4E9YFXqAXxhD+UaknHxpdorzvUbJa5ugqBfytakCIm+u+IYLca8Ukyx9mtx8MS+rB57xcKAUNaM2ea7eqs6kYNtAEyLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PUbHg+Jy; arc=fail smtp.client-ip=40.107.201.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VufIuFexWoG2BccqCJX6Cx1uY9BkOn156nDI4wMOxVk0axi6JV/BwjrkBt+5VuInv8dwivPwKf7Gosarl4cenO0wapKhIlEUry6WBkjfPTl5t9jmvk9hspwkAEX+x/isnMdCCn8QFAqfkHasrabZfs2TZUiRJ/lwW4ri3HVE+UeSp2u4/fNjMGcLj0o0+WebcedemiklqgL7G5YtYOETyMGqO7lGA5hYJOwGJfv2otX90897ne2M34P36FfaIvJVNAsHewz2fz8dBtjafEaGO65u8KUxUMCKK2F3OE4Vp4M/u9orfLwvHxvTLSZKwGnEEW2PSnb5wwD/g1WMt/Swwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOoz0k9rlRrmcz+8QdUpXyBkC4XS7u2op1heuGKRPz8=;
 b=NS7uLMUaHQlFMDXDkSuOiXv/0V4gpxRuyAA4cF2Qh8FmFZiM8tvOWQqdGj121H65iLfXAlrz36DIzET1GqCthFabpPRZyBAJNGDg6bxs1MCr7NaPbUpQiuauWjPcuIEwZgPa5I4ySj34lcml/rV3Qzjt2tw21dMTDc0n2slC8S9fyhmu1cO6/dGus58aL9vitrdZfr2fAbv7bjYykBS/YWEMRkKCjmT+o652fjNRriQPvmGpOCci/qZimWl3t8uhxfmGGkkJT3D4+84WrNiJqdHHRYXknMjLMSNU+9r6vjtQq5Lee5ff2UmOp7vvDbheABjcoSaZzIWbgQtROo0o8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOoz0k9rlRrmcz+8QdUpXyBkC4XS7u2op1heuGKRPz8=;
 b=PUbHg+JyJaOEQYSVQc8HsiCbNlNt+Cg0csLrcQvGXxOudInpVzD7WmG6eFPhaY7K0XbSAAM93o/fAHGZ5SY11tA9xxWM9JxXvSw9coBSRAt00KDUyh0pWZ8nNg9cxNG5tFyjbqF0/t3t8wrZoy6qctTDGZstbwMiA8wxx+YpBOM=
Received: from DS0PR21MB6673.namprd21.prod.outlook.com (2603:10b6:8:2f4::19)
 by DS3PR21MB5828.namprd21.prod.outlook.com (2603:10b6:8:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.14; Mon, 4 May
 2026 22:21:52 +0000
Received: from DS0PR21MB6673.namprd21.prod.outlook.com
 ([fe80::cf40:aa85:b680:dda5]) by DS0PR21MB6673.namprd21.prod.outlook.com
 ([fe80::cf40:aa85:b680:dda5%6]) with mapi id 15.20.9913.002; Mon, 4 May 2026
 22:21:52 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v6 2/6] net: mana: Query device
 capabilities and configure MSI-X sharing for EQs
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v6 2/6] net: mana: Query device
 capabilities and configure MSI-X sharing for EQs
Thread-Index: AQHc2CXbc8fRBuJmuEq63Eta9ef5BbX62syAgAOc7EA=
Date: Mon, 4 May 2026 22:21:51 +0000
Message-ID:
 <DS0PR21MB66738E353CC3DCEB83A82181CE312@DS0PR21MB6673.namprd21.prod.outlook.com>
References: <20260429221625.1841150-3-longli@microsoft.com>
 <20260502150835.281887-1-horms@kernel.org>
In-Reply-To: <20260502150835.281887-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ba2fc58d-34ee-4b46-8c0f-947e2bc2b225;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-04T22:19:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR21MB6673:EE_|DS3PR21MB5828:EE_
x-ms-office365-filtering-correlation-id: 2d7944fe-b9e6-4bb9-27f6-08deaa2b8aa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 nBF7/CFJUznjgfx+yUhMAdaP1MSNFSeXU2dY4Eyt6S7kHqJQ5lI8h2tnodNyM57TSUw4anxnpbluoqL89GJMn082hw0TZtxl8qE8wklF/1Y0NqennGrqdy+HeaGAvkpTvhiQFZ+V/ttxz4teatQtuTarCYWHWDZs0dZrDnqzFVN0ZR80WfwbIf7eYW0BQOy8hQcRXxm91n/2I0AQdFcXbiOVd5RBKDjVV9fJkooAxUmC3T+kNr9VBpI0PSgHMXF6Yj6M0IIl5MHi+CMTNhLGgzsS7gxElE3xL1S06wmrGyOqcXm/QRkrTKSqGm8CBmDGG1EoFLhGxELxrdfCwJSR/xAJDcmO5UU70IBrhONugiSyFAnW6gRHFawISC/dKw/pZ5eov9+xLMOj6CJ6dMB3VJttDI/dg8+9PgD4Uum9oFhGwis1jZaq6YUP4V81HmApvpW7l6gGc4lFa44DZMk2RjC5wIoKOwHQ2YNGdwEFLGcr+UNaIEMvRiRjgsbf3KtmIsGK6OdEndxoElpiZvBi9nNJrlU9943DXwDAcTbX6kJr/9ENeXqOIVMDwBhrbKcQjDmYBrvy/wPoBteYLnWcnnvldhR2KjaPA39zsn1YQ3CwWu0y/Sb7tdlfG+F7Y1rhj8dXMMEehWEX6I/cBkZlFBIkNLI+BuaFqMOU57RuFbuVQ2vHFkUWLAjUufw5DtmB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR21MB6673.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vy4NbB613y6tXrGuJpVdEehP90mlbGu3HcMFBwka1XyvUT33cBA63KgRGMPP?=
 =?us-ascii?Q?0ggdheJx7Gd65D8nmilkCq5XQ1zaJAp47PjCfQ8dKc77OVNz6OsCaAC/iIjI?=
 =?us-ascii?Q?b+K4p2MR9rZ632VSlqDc6zCnfe1a6HOMDRZsuCmKkKP1mxmbKlfWjko4dNzd?=
 =?us-ascii?Q?Am67LBRW/WW6iORH4+pJNj96qTitQUPJ6aNr2OEV5yfZpTIjONkGZieT7r2M?=
 =?us-ascii?Q?aRdfI5NefV36BmFdzU6QqiX4gglaz/SiloLbuP2FizVBv7hb0o+qL5al2mVu?=
 =?us-ascii?Q?HeJWLUvVsVrFxZ669sejU3nGOytAGMUllPHXoq9xzwz1AVghlhGRgUB30Pjp?=
 =?us-ascii?Q?6VDAdWYYPYJPJM94q1+FSsr7SWk4Wgtw0Zbl0DLZ+V46z6cTpx7QDPu68MK8?=
 =?us-ascii?Q?NEChVVKFhHD0QQciOY2pKqwjXR09YBVmRAEn3IETZbmVlWEXo0iPaHAeRFhO?=
 =?us-ascii?Q?B7nWzf9be6lWYkCgtO6BZjF4l/9F6jxiyyxdLnnxbQH/4HRsbylOruvUvcOj?=
 =?us-ascii?Q?QsTPpNtEq02ShmqHja/YZjoNR2gi/+ATRnW+VTAvy7kaEPWlYXrBL8KTKArI?=
 =?us-ascii?Q?U6CAboi6piXoDSAgdyUrgWEwBOjiLCjVvWnm3xi814pX2TuhCNVtTpDKPThc?=
 =?us-ascii?Q?AKw+0pVdZHAXdDsSpVPbmw8P6isi5Bg19i6DRmSf2wLIrjJ//0F/uobLehTI?=
 =?us-ascii?Q?9XMGOAgFHlI6JbYAXNK2kMb/No3K8LWtzDuh8sHiUSVT4KbeqE1EmgUCbzq6?=
 =?us-ascii?Q?4I7bcigcP2MpjiLUnXAASpx7NZuTcZx3mWCGoqvhXbanbHdrrrLQH7GBHQTO?=
 =?us-ascii?Q?BzpeL5WHdOIbmlq0yqOWadCau5BPnU5HhUIjgQsPF61GAKSfxnn1Khtmyrdr?=
 =?us-ascii?Q?XIQZSug0PpTv3nqWFGUA6d/o/SCyqD/5htyyZvJFmGMmP8Zqadj4HJk+Jj9g?=
 =?us-ascii?Q?lY19PoY7A+W7MxkJfVzsGf+2HZkLKkvksxFQ5fcqZ8kCy+v1yNtSF/rt1osW?=
 =?us-ascii?Q?Uy4PQ/8F1PU5TtBp6zg7BNkgDlCY8oiGaRKBj/QnhdOhx6q3hP1RNyntICIH?=
 =?us-ascii?Q?60KFjRKXbooXfIEjQ4NagSAR/BD/iD/0wj3c1ZIdHtewSudMYC+l5a6D1dvl?=
 =?us-ascii?Q?FGrwS6hgMB4U/RgSKAQUKPWWpodIvVBj1hbEUjb7O4j3urkAZsG9uyFN8Gho?=
 =?us-ascii?Q?XagUagD846cqpj6ubn1/oXiDP3+GHLg8sVTulme/XD/72ZJgmCMHLaLIALAv?=
 =?us-ascii?Q?aD77mOzqYUkLQIo20+k/7ScECniCBq/ALQxnQ2g4zdDo3X2rwXUmeZa4cMVO?=
 =?us-ascii?Q?7KkY46oEFhjA8Idcg37vpRNeiOckmTt/mcva+/tJWtk1Wwor56/AnlatVFQ1?=
 =?us-ascii?Q?4oHntR88bb+J+7x1skLy12qD2Z5RzWsGRxZGS4ZCKnv73QkNIGcOwyVkdtWO?=
 =?us-ascii?Q?UvuvPE+kPUOjnnc1WAROA7LeqwBzVLzsx9q07XpTwQr67kxjDRt72IPYLm1o?=
 =?us-ascii?Q?JSu3kTqyD6FTgN4L6yLv7+wtwdR0cQoAkQ/x9EZzCf7ayTcP3q2tNJTQanAu?=
 =?us-ascii?Q?IThK2/SSUvmizNqm9UWkmBJvOxTtAZb4cd2JQjR9+AkPEA9biDUVBvxNwGB3?=
 =?us-ascii?Q?HBwDx4reMSzDcxd1VLbjwqFE6GlXZi52JXKDDqtIMMtz2gfqjn0iu8mbHDar?=
 =?us-ascii?Q?NVlBCt8/X5LZa5Kvcan2evWJXA5n4u2Qv/FJ8TfWmjrYj9LV?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR21MB6673.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7944fe-b9e6-4bb9-27f6-08deaa2b8aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 22:21:51.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eb8n3oaJfV+Uo9+Ghw6g+KEG8WRA1JtByMVYNUrxy64ej36EMI+VVCMHkq8f3drmvE+6QDPwB+MkpW0giNpIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR21MB5828
X-Rspamd-Queue-Id: AEBC84C459F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10618-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Saturday, May 2, 2026 8:09 AM
> To: Long Li <longli@microsoft.com>
> Cc: 'Simon Horman' <horms@kernel.org>; Konstantin Taranov
> <kotaranov@microsoft.com>; kuba@kernel.org; davem@davemloft.net;
> pabeni@redhat.com; edumazet@google.com; andrew+netdev@lunn.ch;
> jgg@ziepe.ca; leon@kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; KY
> Srinivasan <kys@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; netdev@vger.kernel.org; linux-rdma@vger.kernel.org=
;
> linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next v6 2/6] net: mana: Query device
> capabilities and configure MSI-X sharing for EQs
>
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
> Full review at:
> https://sashiko.d/
> ev%2F&data=3D05%7C02%7Clongli%40microsoft.com%7C1b8423bb5d15490288be
> 08dea85cb944%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6391333
> 13365211100%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
> OiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0
> %7C%7C%7C&sdata=3DH6rPcEM62LmbWsXdpSVcVaaec3Wx6KJnTnYS0fBk6vY%3D
> &reserved=3D0
> ---
> net: mana: Query device capabilities and configure MSI-X sharing for EQs
>
> When querying the device, this adjusts the max number of queues to allow
> dedicated MSI-X vectors for each vPort, clamping to no less than
> MANA_DEF_NUM_QUEUES. MSI-X sharing among vPorts is disabled by default
> and enabled only when there are not enough vectors. It also renames
> mana_query_device_cfg() to mana_gd_query_device_cfg().
>
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>
> [ ... ]
>
> > +   /*
> > +    * Adjust gc->max_num_queues returned from the SOC to allow
> dedicated
> > +    * MSIx for each vPort. Clamp to no less than
> MANA_DEF_NUM_QUEUES.
> > +    */
> > +   max_num_queues =3D (gc->num_msix_usable - 1) / num_ports;
> > +   max_num_queues =3D roundup_pow_of_two(max(max_num_queues, 1U));
>
> Does rounding up here inflate max_num_queues and unnecessarily force MSI-=
X
> sharing?
>
> For example, if there are 63 usable MSIs and 2 ports, the division yields=
 31.
> Rounding up gives 32. The subsequent check below:
>
> > +   /*
> > +    * Use dedicated MSIx for EQs whenever possible, use MSIx sharing f=
or
> > +    * Ethernet EQs when (max_num_queues * num_ports >
> num_msix_usable - 1)
> > +    */
> > +   max_num_queues =3D min(gc->max_num_queues, max_num_queues);
> > +   if (max_num_queues * num_ports > gc->num_msix_usable - 1)
> > +           gc->msi_sharing =3D true;
>
> would then evaluate to true (32 * 2 > 63) and force the driver into MSI-X=
 shared
> mode. This seems to contradict the intent to use dedicated MSI-X whenever
> possible.
>
> Would it be better to use rounddown_pow_of_two() instead to ensure the
> calculated queues fit within the available dedicated vectors?

  The roundup is intentional. The primary goal is to maximize the number of=
 queues per vPort for throughput - power-of-2 queue counts align with RSS i=
ndirection table sizes and give the best
  distribution. Dedicated MSI-X is preferred when it comes for free, but no=
t at the cost of halving the queue count.

  In your example (63 MSIs, 2 ports), rounddown would give 16 queues per po=
rt - nearly half the 31 that the hardware could support. Roundup gives 32 a=
nd triggers sharing mode, but sharing mode is
  designed to work correctly and the queues still get serviced. The driver =
trades per-EQ interrupt exclusivity for better parallelism, which is the ri=
ght tradeoff for network throughput on these
  devices.

  The sharing check exists as a fallback for exactly this situation - it is=
 not a failure mode but a deliberate operating point.

>
> [ ... ]
>
> > @@ -1968,20 +2008,30 @@ static int mana_gd_setup(struct pci_dev *pdev)
> >     if (err)
> >             goto destroy_hwc;
> >
> > -   err =3D mana_gd_query_max_resources(pdev);
> > +   err =3D mana_gd_detect_devices(pdev);
> >     if (err)
> >             goto destroy_hwc;
> >
> > -   err =3D mana_gd_setup_remaining_irqs(pdev);
> > -   if (err) {
> > -           dev_err(gc->dev, "Failed to setup remaining IRQs: %d", err)=
;
> > -           goto destroy_hwc;
> > -   }
> > -
> > -   err =3D mana_gd_detect_devices(pdev);
> > +   err =3D mana_gd_query_max_resources(pdev);
> >     if (err)
> >             goto destroy_hwc;
> >
> > +   if (!gc->msi_sharing) {
> > +           gc->msi_bitmap =3D bitmap_zalloc(gc->num_msix_usable,
> GFP_KERNEL);
> > +           if (!gc->msi_bitmap) {
> > +                   err =3D -ENOMEM;
> > +                   goto destroy_hwc;
> > +           }
> > +           /* Set bit for HWC */
> > +           set_bit(0, gc->msi_bitmap);
> > +   } else {
> > +           err =3D mana_gd_setup_remaining_irqs(pdev);
> > +           if (err) {
> > +                   dev_err(gc->dev, "Failed to setup remaining IRQs: %=
d",
> err);
> > +                   goto destroy_hwc;
> > +           }
> > +   }
>
> If msi_sharing is disabled, we allocate the msi_bitmap but skip calling
> mana_gd_setup_remaining_irqs().
>
> Since mana_gd_setup_hwc_irqs() only allocates a single vector for the har=
dware
> channel when dynamic allocation is supported, does this leave the device =
without
> interrupts for its Ethernet queues?
>
> If so, it seems this could lead to queue creation failures when the drive=
r attempts
> to map uninitialized vectors. I notice this is fixed in a later patch in =
the series
> ("net: mana: Allocate interrupt context for each EQ when creating vPort")=
, but
> does leaving it out here break bisectability?

  You're right that with pci_msix_can_alloc_dyn() returning true on MANA, t=
he non-sharing path is reachable between patches 2 and 5. In that window, m=
ana_gd_register_irq() would fail with -EINVAL
  because irq_contexts for indices 1+ haven't been populated yet.

  However, the failure is contained: mana_create_eq() returns an error, man=
a_alloc_queues() propagates it, and the interface fails to come up cleanly =
- no WARN, no crash, no data corruption. The
  driver remains in a consistent state and succeeds once the full series is=
 applied.

  This is a new capability being built up across the series. The dedicated =
MSI-X mode did not exist before, so there is no regression from the pre-pat=
ch baseline - the pre-patch code always went
  through mana_gd_setup_remaining_irqs() and operated in what is now called=
 sharing mode. Restructuring the series to make non-sharing mode functional=
 at each intermediate commit would require
  squashing the GIC infrastructure (patches 3-4) into this patch, producing=
 a single large change that is significantly harder to review.

  I'd prefer to keep the logical separation as-is. If you feel strongly abo=
ut strict bisectability, I could add a fallback in this patch that forces m=
si_sharing =3D true when the GIC allocator is
  not yet available, and have patch 5 remove it - but that adds throwaway c=
ode to an intermediate commit.

