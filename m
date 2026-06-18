Return-Path: <linux-hyperv+bounces-11640-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p53nNzo7NGotSQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11640-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 20:38:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7962D6A22CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 20:38:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=iuWZdayN;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11640-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11640-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB0523023692
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC75403AE4;
	Thu, 18 Jun 2026 18:38:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022074.outbound.protection.outlook.com [52.101.48.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE8401A14;
	Thu, 18 Jun 2026 18:38:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807927; cv=fail; b=i9/CdK1wmMdchcqiytP8K5eLeGSWwiA4qnrx0rg45ayMATf3gC7tJ60mz4bElIzOec/hLp13WDdYGE0361nXj2QOC7HngNI58w3fFgZ7gKGOJ4Zx48FIinmhujIuGI8aTT7am05VHHpp3xvypSlLe4gvysonrM83e1+HHGsXAq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807927; c=relaxed/simple;
	bh=8wjYvYGFbOGXimIZfjufLikEVjCtDLfzWFojplBHhNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JCwa0CVA/hrl0YKt064R5MtFlVuKcpkdr1cfe9V1Nzdgy661XqGu6Qa3x/O8geN6iuXh076qFpniAMrbAgw5i6hao7LIMwkWf5Np6VZnSMEqSSUIUrkkDvnZnC2wqkIBz+2wOe7ac1mMFu9t9raO3w2Aq3aMYXoonMtH3VeqYt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iuWZdayN; arc=fail smtp.client-ip=52.101.48.74
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKNWv1HQ4qtjRtBNg/pQeSkY4bywnFZl9SeLeddfnmI6w5hDkiXeKGC90WJz4FcSKz1IV5tb83mOj1pJ9YzcHcY8QBuo/zyoKTatbBji3Swh/RMHP80fC+WD4Uhpd30wf0t3fSzLSfE3saxMd/bQsWXPsCoWBF4ofxYk1rxDIKNi6xVvXC4doDpy1lIB0uLqiqYsIikDYOHZmHHa/9SzJZyTuBfvJ9/FZuvTkwtuYozXyWOvb9eAdO/MNthgbYA5p+qG5NFAoOa36UIJuNYOXd6PzWbfruBuyRuhPCtKDqIAtqcxb9DHednsYpxtBop33E3HQ5yoDBUH8x7U2kMjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWs0pqBzoPTQXdAObStncvVaVw5iIAZ1xE4NzogYx1g=;
 b=J9SNdNR9Yst83w+Ar+MhgcY8nFr0A+ATpZ2sYmExXRlc7KXmZaTqAcCrjq9iDHZ7cMgpDFvlPdQjCZ9VCrQSRnmspsEdO7prpceP9SzS159Uqi9fkKr/xiuMev+QLLH+4WxlsIOT1t15n6CcG/JmFy+LOnMnz6NlaXYR/9E2RDRMQ0YFi9uNHh7Kt6/7NblJk6HI6wzV8lQD1LvwoqzGN4QHi6aJxuAzw3/8S6vpl+BwcPliE2chxJcw+EE5TONvz+UxB5TH464ikhqIW9m0/ZRuvQhBXUizGJPsxvpY3vmMRSkC523reu0Qf+0G4LMyJB5tAaGT23Z7xYBjB6/5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWs0pqBzoPTQXdAObStncvVaVw5iIAZ1xE4NzogYx1g=;
 b=iuWZdayNJJ/HeSjaRR0iOj7ZI5tXuFeQyaqeA6fqVIkJsui4kXr8oWkhpJtCd4Ez1CRhofQfWD82CGXbbD0vrSW4mY+mmwVueo3ZY2rCaihYACBQxV7g26YQ1CqXkoSgI+V9HvN5mc8XSYVwNMjblmKLPiD8xbrbr7d+F6R8l4U=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by PH0PR21MB6350.namprd21.prod.outlook.com (2603:10b6:510:374::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.6; Thu, 18 Jun
 2026 18:38:41 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6%5]) with mapi id 15.21.0159.000; Thu, 18 Jun 2026
 18:38:41 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <DECUI@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	Long Li <longli@microsoft.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>,
	"dipayanroy@linux.microsoft.com" <dipayanroy@linux.microsoft.com>,
	"kees@kernel.org" <kees@kernel.org>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Sync page pool RX frags for CPU
Thread-Topic: [PATCH net] net: mana: Sync page pool RX frags for CPU
Thread-Index: AQHc/tW7ny4CStGhZ0mFMn/7JB0H2bZEpWmQ
Date: Thu, 18 Jun 2026 18:38:41 +0000
Message-ID:
 <SA3PR21MB38674EB484BFB58C2EC9A2B7CAE32@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260618035029.249361-1-decui@microsoft.com>
In-Reply-To: <20260618035029.249361-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cdb5c85e-e3b6-48bc-a83d-5595288bb4a5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-18T18:37:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|PH0PR21MB6350:EE_
x-ms-office365-filtering-correlation-id: 41bc5081-3ba5-4082-9741-08decd68d1ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|38070700021|22082099003|18002099003|6133799003|921020|7053199004|56012099006|11063799006;
x-microsoft-antispam-message-info:
 6Vpr//cQqa2Kj6zFAy6diWzONKQlWgKmiOVzQihdyGpz+gVWRf0ti2lUBfJhjDI7T+6zSTAjrODZFuV1tZ2OED6FunBh9OULoXx63Erczu1j5WtwhaHwGzErBhvGpFvMFBRGZaBpoUtdInugjvWRw68TlFYOwYBAfEgcQc93iNNPa9ov0M1RLjVf7vOiWis2VZkrRk/pV19cPii7adetgczp0/Q1Zy17I6EX9BUDhpA/KusaKw02N+r+EIWRy69xXEdV0ZL/diui0cM+JVzGC5mBJ+XXlRWWMR2CwJL6iEpSHFkrPXFZSU/S2ChvzyOUP56uE26+F5O0Oea0Vyr4/+WS/8KMz4F8nIJ0eWnTVB0PXFTvqy2qsSscNULV20be8pAc+c6zohWQai5N2RHr17g6fn/jbvPKEZGdlJ8Q7SdRZULFv2l3+coEXR3868gp6wmXfNt4UxZloPaG7+AZF9abp+RGtxulBUXrcweh/5XFudTyakO9nBCVxpa/FaH1Bbw/jQ995qf+U2NSEyq+dsqZFW1dLvle0YUK4tEAIk7ZzAkw2BaPnlYhsl2f49KsxxfWmuMapwBkNh7IGQSCr7a5CQBKgOl2Tc48EzZ92s+Xk1+PC76rMjbTvTxox2VCDACHpwkjg4CFzuCW2khk1/vtRkP0b9gv785n+PfV3Omo+tvP9cVUBe98CZj5m2PgAfL4IZMJWx/JKncY1dvnVv5zi8IdhwiYmoQldNpMBYqHI41YZElURO0r/HzzAZ3ZtoTvA3JM+2MXviEisAu93g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(38070700021)(22082099003)(18002099003)(6133799003)(921020)(7053199004)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Yy8pTyBqkt5FXbevx6vrhdq+U6vSw2T3iXbPtqL0bCGcV8UbZE5UwyGbRjhC?=
 =?us-ascii?Q?SLId3xNVmX3QeynqocDFFaJ4JxEkKx+ctwtFDYrn3B7Dv0vVa/d0LurOe6Gj?=
 =?us-ascii?Q?ePUQeIPdMb9c8rgpXJU56yEt3JFNCywwFi1ZsjvwXpIdA4i94Aobn9s9SKmW?=
 =?us-ascii?Q?aNJz/SBYsjUWllTCVKE742KUbR73oZjql5qhd8oUZjFRFX5sau5Ctzk0FGve?=
 =?us-ascii?Q?hxZTcqdW097TsoNiDSdH/UatePxOsucDZLImaz9yK4kCwlY/iHqEwDh3ZJky?=
 =?us-ascii?Q?TxuAjFIvT+BZyzzfC9EGFIDwIzfnaeLseRJZLg/UqRjTxcmDV+f4+xJpc79q?=
 =?us-ascii?Q?hvA99Tw9LUjv5OiwwiZU3TCjuGzsGwC9hHQcaLuJXUe+tVSk2jWy0iNKNXkC?=
 =?us-ascii?Q?j5ZYXTGLg59L6QACyxJ6EKCLeYC1wv+SGqD1ZQOFasaoBthjQ8+bI37eab8B?=
 =?us-ascii?Q?qcreKQjLX5RUFb0G07R6CaP6ichDzLzNO1+TPe3HBoCFYSIA616d5P7BM12c?=
 =?us-ascii?Q?K0WNReAThuNq4i7bZa4jlxJ8dobniJwm5sSyiJRPSSwfWEZGqwbNzBYy6kJG?=
 =?us-ascii?Q?TY40bQZDfSUi1HHMkHNW09RFFRhFRYHsu7lDbMpGFnDstui6IKc740F5aRF9?=
 =?us-ascii?Q?I3ZuIFw28n6A8o2Ien3XaVEnlTUWfSuNOph+62Z/VVokOm1h7cQDCbdSCO5D?=
 =?us-ascii?Q?hgkEAxqxad3C/aJa+DzP4Dfe9ke/D1zIzcV0N26R4JAZq5188oKTRgHZrVwf?=
 =?us-ascii?Q?PDDYe9iC+0qiIsb8wwur/xsMZyWJ96Q/GjNtHuLVw8lY7Ur11tRd1DlR835A?=
 =?us-ascii?Q?na8xrHgrZHAIEK8s4MkVZdnwV1OGz71OoJ7An+DeBwj3hFpjgw5ZgRaQTiPC?=
 =?us-ascii?Q?hEzUcNyph1uo+g6L5YybosnPBgha2XYZkxz94OT/OIZ8HJNMNyrTc5spZHyy?=
 =?us-ascii?Q?8V5ZnVc5NOMfYyczivVyhBRKo/8kO8hl8J43RVsgF7vTWHVwYImWKKbVX20/?=
 =?us-ascii?Q?+H0W3pq9JCcrp/L5yTPNaOGXBsOnihlmTGmMfyZfJ5w27yaJYwJ25aDrC7Ip?=
 =?us-ascii?Q?UJ9tasCYhCqOnH1juhj6APDtHhQfSzHn/5E9B04kIMJh3nZOLf9iixX5LGhm?=
 =?us-ascii?Q?rYf2zGmu2UyWucsHlDoP6Jh9aSQL81Bcpz108XqmjzlmEo+uiLjzt008BN31?=
 =?us-ascii?Q?unIlm3LFEoA8pC22AQU7/AlHl2FgntxTEbeucPkI7NeUb8d3Qp5XI2ZVE0Yl?=
 =?us-ascii?Q?YFOtEBTNy8FOeGdCYybaH+E18ffvJd088rkATRj55MMk+pYdybaZ3+XlOfCE?=
 =?us-ascii?Q?Y8DI2qRQfIFhOkNGCO+rRcXYc2VJYGegVE3Wp5LFIfShGbRHygwLv6rR+Afu?=
 =?us-ascii?Q?tlCtbhAArib6OyMSUspKtHDOI3mrm6OhxwpG4JlVsC5TWpj1QFbHtdObUgok?=
 =?us-ascii?Q?HnG2EFt3NCTtMA0zS7GXNUkPNTKaQHUteyIrkh/jakkI3yzaYljUukh5wXx/?=
 =?us-ascii?Q?In+hKYGvT25dek/yl+G4halwP7vUofGg2sL+amEumulmlY5b72D/zv6cOEY6?=
 =?us-ascii?Q?DKCP9SfKStAamCJKeeyrKdo9DOKlYe9thbnnCUag8gshhPH/QqLZeS7iwrcm?=
 =?us-ascii?Q?Mj6Q30yyTsMkLfNrW5Fqbz30OjX8LnuRNoLhJi2VF3eawKQIlPGYxDxBm5g+?=
 =?us-ascii?Q?+Lih/V4cy+AQdEGG8IzDRhf++uGHMv+pvAuSr9gScRW8aQk3Hx/2EsoZEh1f?=
 =?us-ascii?Q?kJgnf9bmaw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bc5081-3ba5-4082-9741-08decd68d1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 18:38:41.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6r6W7EBj9qJxHFO3fCkLNwNW+9G37yy+YI/O0zX0+Si54LingUbp14rUt8C6KVLt64/GTjQOVzmxtojrQHPfrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB6350
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11640-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:DECUI@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:jacob.e.keller@intel.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7962D6A22CD



> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, June 17, 2026 11:50 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Konstantin Taranov
> <kotaranov@microsoft.com>; horms@kernel.org; ernis@linux.microsoft.com;
> dipayanroy@linux.microsoft.com; kees@kernel.org; jacob.e.keller@intel.com=
;
> ssengar@linux.microsoft.com; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org
> Cc: stable@vger.kernel.org
> Subject: [PATCH net] net: mana: Sync page pool RX frags for CPU
>=20
> MANA allocates RX buffers from page pool fragments when frag_count is
> greater than 1. In that case the buffers remain DMA mapped by page pool
> and the RX completion path does not call dma_unmap_single(). As a result,
> the implicit sync-for-CPU normally performed by dma_unmap_single() is
> missing before the packet data is passed to the networking stack.
>=20
> This breaks RX on configurations which require explicit DMA syncing, for
> example when booted with swiotlb=3Dforce.
>=20
> Fix this by recording the page pool page and DMA sync offset when the RX
> buffer is allocated, and syncing the received packet range for CPU access
> before handing the RX buffer to the stack.
>=20
> Also validate the packet length reported in the RX CQE before using it as
> a DMA sync length or passing it to skb processing. The CQE is supplied
> by the device and should not be blindly trusted by Confidential VMs.
>=20
> Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers
> instead of full pages to improve memory efficiency.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 61 +++++++++++++++----
>  include/net/mana/mana.h                       |  8 +++
>  2 files changed, 57 insertions(+), 12 deletions(-)

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>



