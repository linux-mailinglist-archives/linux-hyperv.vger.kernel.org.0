Return-Path: <linux-hyperv+bounces-9501-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOtwFkqauWn5KwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9501-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:15:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE28A2B0C1D
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37EB31BC49E
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D93F7860;
	Tue, 17 Mar 2026 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VAAoSvD7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020124.outbound.protection.outlook.com [52.101.56.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1137F8A5;
	Tue, 17 Mar 2026 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770904; cv=fail; b=NL74sL+8DPHbGVH+GSS/hNVqbtvzvmD+vkuFSjmrlu4pQJOlmA+w/eal6um7ghTN0wWCnF3R7n2Vv5vI39tbRs6REvFaPOUf+093XL22FvfnN5iYXzC04+tUape4/S/NlFvg2AStwPh5q6L33iNXEFxHrzqK/UG9/oxotHsr+uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770904; c=relaxed/simple;
	bh=6ICMuMap2wCT4xFhpeJY5GBLUl2T7eHYH6213kpEcXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E40yylJJJx9FhYlBIJSimpOR0I9vyENFTB/otqO+zAqZiYh5/ZkJvCyy7GYsFUYgCd36/XfZXuJpwv+X4pgQRLdXefMX++v3KdouTWTtulWw0Q7wBveMoQZQpuUgvkwlK2DtqV5PkhN58PV60JJz+bTI5eRdAKjCYtpdhn7nn98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VAAoSvD7; arc=fail smtp.client-ip=52.101.56.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpMWY6NB/aIHu7otpq460z83IH5/XnqwR0fACtJlgEKI0sxcCyNFs86daTkHWx8RpvjKLJdYaO059DsHL11v5PI+s+A6tajjIbk60JaxyBrXP26tnUVaaOHSh2qxr99cqr9wIWCzXAbMVbgOYb1jl94o9on0xnmVPI/4waiCWdgujf+ZNTlDCCZPaww6Q5AKTerwPPy0RxGnOJJj7n9E5wKXa+2c/mFcWysWCKN0NeZs8nmdcVoDJzfRBR5HuTKcA8bq/5FOTkVqMt5kH7O4Vu+iVMwe1PWHgr+OlnmzXoPTOFCUXQUPJ/KOOLq+w6o85urDV6kWmSsZjahuG2BMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVpjdL6OSanXKM84Hg0dhD1GTS6PFdZ0lmESm3Dcjew=;
 b=ECawV8PjlO5TwD9TmLdTzNwb8RSGEPAXdIMFOgHnsr8UBimpbryIe7zFLn4+JDFsR5ngtdrA6ahJZn+v8cprPxkmCKtyggap5uqEiVkvG3JaBToDr/4k9ItCxESP24/mgm/Csqy+tHSpdSIQa0zT071Hjakdirgs1+VnmDIyzdSRt8oP0HFYcUL/zL0ZO0mm+cOyWtNe2pSUG6Ect9LMQTWdxqBWPhVcJDzUCbXtcaXO5gcIlE++4J8lpS2pz6v1Rj7Shz6QlZtB1Vdnyp+5BHLN0CO0kNQtbp+kH4R8Cvrx+tT0S+KdHXjJqCKNki/H81bGGUm5iMqgLALQYZ+aVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVpjdL6OSanXKM84Hg0dhD1GTS6PFdZ0lmESm3Dcjew=;
 b=VAAoSvD7BtPymwHXwgqHSkKpJXUZ+v6/72ykbVZHXwHc93QL3SeahmYvvCw1E0EqJhv+5VBNngpvhqojfkdyta5zX/Z2zRbzlxysWo6wISasmJbDL+v7DtQ5nYiYp+G+0mOoB8Gc/I4K+4Li6lRIo/Y28g4li/l+8zIT4Yx0yg0=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5864.namprd21.prod.outlook.com (2603:10b6:806:496::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 18:08:19 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.008; Tue, 17 Mar 2026
 18:08:13 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bernard
 Metzler <bernard.metzler@linux.dev>, Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>, Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>, Kai Shen
	<kaishen@linux.alibaba.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>, Leon Romanovsky
	<leon@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>, Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>, Selvin Xavier
	<selvin.xavier@broadcom.com>, Yossi Leybovich <sleybo@amazon.com>, Chengchang
 Tang <tangchengchang@huawei.com>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [EXTERNAL] [PATCH 03/16] RDMA: Consolidate patterns with sizeof()
 to ib_copy_validate_udata_in()
Thread-Topic: [EXTERNAL] [PATCH 03/16] RDMA: Consolidate patterns with
 sizeof() to ib_copy_validate_udata_in()
Thread-Index: AQHcsbadi7VVR4oIVkSNg6q88BiNxrWzDorw
Date: Tue, 17 Mar 2026 18:08:13 +0000
Message-ID:
 <SA1PR21MB66832D77E0D8C3CE1C6FAF03CE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
 <3-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <3-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=974d22bd-4932-4006-8e97-0e11c445f105;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-17T18:07:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5864:EE_
x-ms-office365-filtering-correlation-id: 93f2594c-5e5e-4042-f86e-08de8450282c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info:
 /sthhaM+764cLEARryirWsA/dc9MVa1mN7fY/dUwq8BSnZAFBQR4WQgZJisAk4nUaqdX2a53D8hoGngbzDljdcm0nGw2x74nmC901X0eu82T/7+bLe2x06NNjj7wzMFm1UbFDd31WhgeAnxEVlydGMbYSqV9MMeTNzaD1h33OMyMIIIZz464fczFdPF3jITExJOP75H1CJObM9Y26KGen4aoak+itpfwf4gOO2ibu9c7oLQviWz6YN1/RkXAbYVSwMQNiwUGceDXUT7O6BrEkxwkx4bbjXgi2PxrirbXVpYq5CPKwNsJ+mhH/UKS2cbA4+I7s5vQT7HNQCBTp/MVgcg26EdUJqUT5vUe7qnJ0Rueeah01GAv9xNYjXIbNB9zkbOnX1w8T0uCi2jnxYI/4JPaCDUO77AqGIemUpxHeC4nM/2PojcVk3u/sFf9M3zJRbYBAjBQKZgrM5JXQYsqtQ4xGkn1xHQZjtijvoUmxZDaT4O0WkyhBjFA6H6vuERqY9cieL74O+0QNslk1KkZiy8n8WhO5nT8vk9tzAh3JHyll8q0Wn2z2f6gPiYzNvkJ9cnrzWardNgKXpnXThkYxLG/Z44gp0idSgvBNVVoYXddskk2goAmb+NnMCilOcgiRSm2/9+5+Sh4nIXwdJ/K+zfsqsslAqGIEKms5yDuNvKksScRyVCZN5BYracFjJ+YFpCp2F5xoUYW/2mZNofcUTY1RmquacCck4Fr03y4DnIYCo9vDVQUqOCT9MtKD6UESqOhLprl7W1Bk1l3b8RPCoeVMPY7zJEowegiICRzmvzacVrh7JT5nc67F22gQ1wv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4y6wdAwt8MYrZEatpyPeC1OCNDFl2/hejzY0u7qBZdICUe8CIF4oby7m9u1b?=
 =?us-ascii?Q?gCHO30fP8ra9H4zc/YCU6nX85oLEr8NzRLOHEEZySQLJJfLY9/kYTTMPgiBT?=
 =?us-ascii?Q?H2mjSOExYgOmoddpP3Bf/oyDYm6+WrbNwDMWKQE7+ri+HYaI2jZggEcVKUjn?=
 =?us-ascii?Q?VX/BV8QtQ1evLWemG2zaA2VVeTh2iLO3L5vJXPP1z4olhavfR3AgyJx1PwK3?=
 =?us-ascii?Q?20XgiBVKNOFToC9+2JoGVVZ34NglBlFuNi8ItJyvR+XAgIm84j8ObFQdTjQp?=
 =?us-ascii?Q?IuHbfxKOJjScGu4W//aRy/PENIsswq3rjsB3MOKEtohGZYAU7NX4cEAFr6/B?=
 =?us-ascii?Q?mucZlTcgWEUrdu+LkFVsN1i/kEl/5p8gJh1yNXegoXHPeb7O0TcxuIWiLDox?=
 =?us-ascii?Q?DCUC9EXaWljSum8qcgWnX3FXYf4W72ZKDWsw/ln6DxaIE1zk+yzl1lmXNVN1?=
 =?us-ascii?Q?mCyU/RbXiWYKo5jVHn4ttoN7YqmMNbibWaVQZFXo0mQ2yNxVD+ZW3POR8yZK?=
 =?us-ascii?Q?0b7GAP3yoE7v+sf3bXbt3ueb0WhqGjTiPXFvs6W+F9AoTFew45eFtBhXK0iL?=
 =?us-ascii?Q?KF1+65AQsIYvV5hClYs+92rRATNJm10V+z0chERks/1Sbykz9uGuMhkt1+CQ?=
 =?us-ascii?Q?TJ3PYCtS2IbTBFYAnpCYqHPzTaJPi2HTafDlyg3ubAgUSghf0ncMaqByPCtP?=
 =?us-ascii?Q?8E2ZbAv3+/T4y9xdLtWoSJoLK/YJqsSWVBiF4aJ/3Z7mvJM8/hWJQbSXUVv2?=
 =?us-ascii?Q?nYtXCYPl33ieUTL93O1/EE/iO8FLPchknKpfLkgK8Uwt/7UN7inlY5NtDNBQ?=
 =?us-ascii?Q?K+lPugQqBlx1wlQJZnM52TLOopJ1PTMLfC2XBfXZPJ6uATlzkHJ5xNQ5oY86?=
 =?us-ascii?Q?bfMOSVOqLC199sD3cKQT2eu9gySLvws+VIuInCiBHEPhjNcXinuZgbK2Z5LT?=
 =?us-ascii?Q?sy+aVMQgvcLh/LWZt2WmI2pxtnpFqqYeb01N6+n3VNm0pNy2XieFShc6Upfk?=
 =?us-ascii?Q?PathFFc3wdOukky8qc75BgAVZ816Y18m7FVJgGRXRbGWRMaZx+cBgw9JGXuj?=
 =?us-ascii?Q?oZoQHdsF1YLGpMuPMrLqDuil7A8ZJ+sJoD9LSEdQ4yErSok1MW/N23nyHJhy?=
 =?us-ascii?Q?+kYNe/Mh3Iqb+Byz01JvJoBN2BwebGuMsNzP5Joi8Uins+p9i4zvcw7qhVq0?=
 =?us-ascii?Q?7LNwFQDzvL+GH+NZpPbFCxdVO5NDISusWsvkzIxTSYYjn37y6IYkQ2WRqtOC?=
 =?us-ascii?Q?/JD/qwh5ZO4d//niuKaFjZfwaZGAZYXmw8+lpI5x0X7oEUTAvzhzZ+I5o0sm?=
 =?us-ascii?Q?rx/yE6TFAoIva+HqW3En2x3hu5FSRrOJ0KVFGPkEO5q97zxYei3T+dNIiUmu?=
 =?us-ascii?Q?4m10gTKOtk9sj4+Zscb36vYXQvMVlUzDXwPHtoc6jEigIz4bF5OAlUCb6Iar?=
 =?us-ascii?Q?77vwU4O5+umAskMN1cs1+fTQ9WIlLWCmZ+PkOo7K2X9t0TgJXkGUVMSkpDnU?=
 =?us-ascii?Q?c30thuSbiA0ArRCjzs8UYwA/Hit4HlP53fk81iqOpOHJ5MwsVMlwFlik+uGV?=
 =?us-ascii?Q?tTy9WcF3o6CO9CWk2JkCDllt6IIgLCJTrcY+KgR3aeYpyeeZXnKxfjS1jRqq?=
 =?us-ascii?Q?3DNfEyv3113MCBrQCcGjja61ZPjn1sVktEUK8F23CBVTlYQObJuweYbq08l9?=
 =?us-ascii?Q?N/nn1lKdHxKjmgfboBTpV7Chk/5/Bx3sTkYgGm+QE39RrOPa?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f2594c-5e5e-4042-f86e-08de8450282c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 18:08:13.9260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAMgQvRtFG6a7cOXcfg1/CPM+FLP2QSgp/G7dicNZn2QgKE0WByO9igQIwaAramxruRVFRe55r4KYD779bjrUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5864
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9501-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CE28A2B0C1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> Similar to the prior patch, these patterns are open coding an
> offsetofend() using sizeof(), which targets the last member of the curren=
t struct.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/qp.c       | 27 +++++++++------------------
>  drivers/infiniband/hw/mana/wq.c       | 10 ++--------
>  drivers/infiniband/hw/mlx4/main.c     |  6 ++----
>  drivers/infiniband/hw/mlx5/cq.c       |  2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 13 ++-----------
> drivers/infiniband/sw/siw/siw_verbs.c |  6 +-----
>  6 files changed, 17 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 82f84f7ad37a90..69c8d4f7a1f46b 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -111,16 +111,12 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp=
,
> struct ib_pd *pd,
>  	u32 port;
>  	int ret;
>=20
> -	if (!udata || udata->inlen < sizeof(ucmd))
> +	if (!udata)
>  		return -EINVAL;
>=20
> -	ret =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
> -	if (ret) {
> -		ibdev_dbg(&mdev->ib_dev,
> -			  "Failed copy from udata for create rss-qp, err %d\n",
> -			  ret);
> +	ret =3D ib_copy_validate_udata_in(udata, ucmd, port);
> +	if (ret)
>  		return ret;
> -	}
>=20
>  	if (attr->cap.max_recv_wr > mdev->adapter_caps.max_qp_wr) {
>  		ibdev_dbg(&mdev->ib_dev,
> @@ -282,15 +278,12 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp=
,
> struct ib_pd *ibpd,
>  	u32 port;
>  	int err;
>=20
> -	if (!mana_ucontext || udata->inlen < sizeof(ucmd))
> +	if (!mana_ucontext)
>  		return -EINVAL;
>=20
> -	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
> -	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> -			  "Failed to copy from udata create qp-raw, %d\n", err);
> +	err =3D ib_copy_validate_udata_in(udata, ucmd, port);
> +	if (err)
>  		return err;
> -	}
>=20
>  	if (attr->cap.max_send_wr > mdev->adapter_caps.max_qp_wr) {
>  		ibdev_dbg(&mdev->ib_dev,
> @@ -535,17 +528,15 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  	u64 flags =3D 0;
>  	u32 doorbell;
>=20
> -	if (!udata || udata->inlen < sizeof(ucmd))
> +	if (!udata)
>  		return -EINVAL;
>=20
>  	mana_ucontext =3D rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext, ibucontext);
>  	doorbell =3D mana_ucontext->doorbell;
>  	flags =3D MANA_RC_FLAG_NO_FMR;
> -	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
> -	if (err) {
> -		ibdev_dbg(&mdev->ib_dev, "Failed to copy from udata, %d\n",
> err);
> +	err =3D ib_copy_validate_udata_in(udata, ucmd, queue_size);
> +	if (err)
>  		return err;
> -	}
>=20
>  	for (i =3D 0, j =3D 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i) {
>  		/* skip FMR for user-level RC QPs */
> diff --git a/drivers/infiniband/hw/mana/wq.c
> b/drivers/infiniband/hw/mana/wq.c index 6206244f762e42..aceeea7f17b339
> 100644
> --- a/drivers/infiniband/hw/mana/wq.c
> +++ b/drivers/infiniband/hw/mana/wq.c
> @@ -15,15 +15,9 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,
>  	struct mana_ib_wq *wq;
>  	int err;
>=20
> -	if (udata->inlen < sizeof(ucmd))
> -		return ERR_PTR(-EINVAL);
> -
> -	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
> -	if (err) {
> -		ibdev_dbg(&mdev->ib_dev,
> -			  "Failed to copy from udata for create wq, %d\n", err);
> +	err =3D ib_copy_validate_udata_in(udata, ucmd, reserved);
> +	if (err)
>  		return ERR_PTR(err);
> -	}
>=20
>  	wq =3D kzalloc_obj(*wq);
>  	if (!wq)
> diff --git a/drivers/infiniband/hw/mlx4/main.c
> b/drivers/infiniband/hw/mlx4/main.c
> index 73e17b4339eb60..16e4cffbd7a84d 100644
> --- a/drivers/infiniband/hw/mlx4/main.c
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -50,6 +50,7 @@
>  #include <rdma/ib_user_verbs.h>
>  #include <rdma/ib_addr.h>
>  #include <rdma/ib_cache.h>
> +#include <rdma/uverbs_ioctl.h>
>=20
>  #include <net/bonding.h>
>=20
> @@ -445,10 +446,7 @@ static int mlx4_ib_query_device(struct ib_device *ib=
dev,
>  	struct mlx4_clock_params clock_params;
>=20
>  	if (uhw->inlen) {
> -		if (uhw->inlen < sizeof(cmd))
> -			return -EINVAL;
> -
> -		err =3D ib_copy_from_udata(&cmd, uhw, sizeof(cmd));
> +		err =3D ib_copy_validate_udata_in(uhw, cmd, reserved);
>  		if (err)
>  			return err;
>=20
> diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5=
/cq.c
> index 643b3b7d387834..f5e75e51c6763f 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -1229,7 +1229,7 @@ static int resize_user(struct mlx5_ib_dev *dev, str=
uct
> mlx5_ib_cq *cq,
>  	struct ib_umem *umem;
>  	int err;
>=20
> -	err =3D ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
> +	err =3D ib_copy_validate_udata_in(udata, ucmd, reserved1);
>  	if (err)
>  		return err;
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index fe41362c51444c..c9fd40bfa09eb2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -452,18 +452,9 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, stru=
ct
> ib_srq_attr *attr,
>  	int err;
>=20
>  	if (udata) {
> -		if (udata->inlen < sizeof(cmd)) {
> -			err =3D -EINVAL;
> -			rxe_dbg_srq(srq, "malformed udata\n");
> +		err =3D ib_copy_validate_udata_in(udata, cmd, mmap_info_addr);
> +		if (err)
>  			goto err_out;
> -		}
> -
> -		err =3D ib_copy_from_udata(&cmd, udata, sizeof(cmd));
> -		if (err) {
> -			err =3D -EFAULT;
> -			rxe_dbg_srq(srq, "unable to read udata\n");
> -			goto err_out;
> -		}
>  	}
>=20
>  	err =3D rxe_srq_chk_attr(rxe, srq, attr, mask); diff --git
> a/drivers/infiniband/sw/siw/siw_verbs.c
> b/drivers/infiniband/sw/siw/siw_verbs.c
> index ef504db8f2b48b..1e1d262a4ae2db 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -1373,11 +1373,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u6=
4
> start, u64 len,
>  		struct siw_uresp_reg_mr uresp =3D {};
>  		struct siw_mem *mem =3D mr->mem;
>=20
> -		if (udata->inlen < sizeof(ureq)) {
> -			rv =3D -EINVAL;
> -			goto err_out;
> -		}
> -		rv =3D ib_copy_from_udata(&ureq, udata, sizeof(ureq));
> +		rv =3D ib_copy_validate_udata_in(udata, ureq, pad);
>  		if (rv)
>  			goto err_out;
>=20
> --
> 2.43.0


