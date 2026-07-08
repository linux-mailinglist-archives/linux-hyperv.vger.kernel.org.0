Return-Path: <linux-hyperv+bounces-11876-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sYSXDYm5TmobTAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11876-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 22:56:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4672A58B
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 22:56:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=NZeUKFtS;
	dmarc=pass (policy=reject) header.from=microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11876-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11876-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5317302C909
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8453E7BCF;
	Wed,  8 Jul 2026 20:52:32 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020115.outbound.protection.outlook.com [52.101.56.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73F3E6DC8;
	Wed,  8 Jul 2026 20:52:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543952; cv=fail; b=JUlB4MWK/LQgqQmDDLHIRLUOQxVEV9phztd8FOlyg9sOmOGK8Z9tHdw3xYUSIyIlWxDpvuTCmZ4EVVumv5L0dubVClo8K0FQmLNcoGh6EUAGouEeGxma9X4FOn6xBZQ7BCNRKLhfSIrsREq3GUKhvcR446hRt9MkP61wR3DO7S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543952; c=relaxed/simple;
	bh=V3tcwAmamNP3U0FtU0nbdXsN3gs+QB18HRAa01DsH/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ian2BzuX622z7BkT/M54uOe42vmCVGS57HJoDreticznZZYNUzWeNAx/dlcuV6e5rsfYEXs4yi6jeVX2v6gUadhTdsbx1nqywKPkqNrMggPeQMQHJim83jQ1Qwo0Ccm2btXyeqGfoV2ptaMuoN6pZx9jJ+uuqW2FZ83wJ6C47SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NZeUKFtS; arc=fail smtp.client-ip=52.101.56.115
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v09Cnlp0HkS3SOVQmZNWZN7FiV17xnAaRgFfgMjNO9VIm+aajZHNWzJagcCTgZvPTAF8yfp00oYJpy+zUt7sF5rSFpJ6nY/aEkop05s6/PEDQ/n6tEKYrF5sf/PzsnH7XW93EKVj0rBeBteWdvCz2+mxS+BosrKJolHYKPTO9w1/ZVhtsbMDpxExlKQA+cYhGy6yZ4s384IxVC/AXk56q2fgVBBGYgmUWkJpzeaaCaUUZe+v4AkAh9I3NeAfF7u0h1p2M0tR4MCp27NZD75+KdJYCWX2KFOJa//HQkCuhZvtlhsBWqaoqxhIZ5LuTQywka/HfnUN4jjkG1vefX/PJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JievpMki2BNvz2AZE4jC/0HDkNvVUBBeFEiVXSB2deQ=;
 b=hYIjJ1RhN6Xk1nBlB+Ls6DNjWxtKBPmSIs7cymckRL+IKcR/dBWqaZ6n/1iynJZv5nGEtBbRJDGkOJ3zrx3Sb16LDGjBTYcMPsB6oE+L35KczjMbx8lhUJkty5SfAmSR5Ka9OatKTCtCvgElLJVKm4wPtlcCTGUsGI6MoaxoT4Gae4/KBaqFmEKlFnn7KzkmySOku/6xLoLTvc33Hhy3YGQdBjnCn0WYmQGtsxde97gstW/uEqBhQWDz1K8T7xsq1HSLtmkaWJ9BZhpNdt/Jd07Yi9v2JldGVM+VQ3RFYMZV0tUw1O4qGKGbgcS2wou5shWbIGhjIxv+P/hekj4azw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JievpMki2BNvz2AZE4jC/0HDkNvVUBBeFEiVXSB2deQ=;
 b=NZeUKFtSeKu6oegLySW3F93FgksgvKTqw57ax2p4PPi49qt5BhUgL15EGWAku1QAysRYPx6LlJcEujuS8fVrWEkfV8iFJuq7GgxJvcD9BkOSf6/Iy3P3h0kaWOfs/lxa1R9+Xbh+tYZJjp/CULSpMwk1d25B9OKmyWvLkplON2M=
Received: from LV5PR21MB4704.namprd21.prod.outlook.com (2603:10b6:408:307::7)
 by LV5PR21MB5137.namprd21.prod.outlook.com (2603:10b6:408:307::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.3; Wed, 8 Jul 2026
 20:52:27 +0000
Received: from LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb]) by LV5PR21MB4704.namprd21.prod.outlook.com
 ([fe80::144b:98da:1262:2ebb%6]) with mapi id 15.21.0223.002; Wed, 8 Jul 2026
 20:52:27 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>, "haiyangz@linux.microsoft.com"
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>,
	"dipayanroy@linux.microsoft.com" <dipayanroy@linux.microsoft.com>,
	"gargaditya@linux.microsoft.com" <gargaditya@linux.microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Add handler for
 sriov configure
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Add handler for
 sriov configure
Thread-Index: AQHdCYO4UEKqbe3S7Um7CSrPXTXPZbZjTwEAgADUuCA=
Date: Wed, 8 Jul 2026 20:52:27 +0000
Message-ID:
 <LV5PR21MB4704E2BAE81785FF87887F77CAFF2@LV5PR21MB4704.namprd21.prod.outlook.com>
References: <20260701180116.507690-1-haiyangz@linux.microsoft.com>
 <20260708080854.64655-1-pabeni@redhat.com>
In-Reply-To: <20260708080854.64655-1-pabeni@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9838eb2b-3496-4941-9584-0e7991e8a061;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-07-08T20:50:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR21MB4704:EE_|LV5PR21MB5137:EE_
x-ms-office365-filtering-correlation-id: a6bc621f-41bc-4d7a-0823-08dedd32d1e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|38070700021|18002099003|4143699003|5023799004|4133799003|11063799006|6133799003|22082099003|7053199004|56012099006;
x-microsoft-antispam-message-info:
 vsEB3IVSLqIrWccc4zg4XYVzGAyYlKh/z7amnriw0ipyxgWl2ETS+EXq2lPCq1IMvsuLPuRR5dqooYaa4lrq8LC2mvmxMGtKM7pjKNqgIAXUAVMYqfLMFbQO60sxsk+RIuGoWa4w9NJPGI3rW8Z6nJnAwuwmw7sU8POdaBnkSknbcObzU/dSQTlz2TjhfHytdjM8ekSN4ZbjWN9bb44QiMB9X3I7nqmwf65KQQmOttb/6d6k0cae8Nv6iJXJeLolHMwoX+fwv9jgbEbvMqgAa1u8kjI90Ug/aQYal6ws09yWvdTNbflnRLbUwFUnvb/iLMDeE3bYnZmhUyRfT+98qam0AaiGB55dGFjkp1B5y48zxlbxXVImPxsfYorvvXJm/1PKXB1WokKkBYtLaSr+iIYInIwLSu6iNOedWHGMMdOkjpPoyvOecWrDgNH3iYoxfe8gwWeczCjwqCne+Q52kDjGDbeQRjhiByQOBAXKwuWwqLQDWvHTL39rWOVUBlvpFIfauEFlpxOuN+hiLX4V4MiijMfKjhUjxfZY6HdeD1y8/zEU1OCcCQX8bwv+lfTWw1zyfLJW12Ks0emgKQI18PxIJE9o0UHU2OO4iIJxliLqOoLf/4gqvRYzXKTJeKHGNtAUksNjPWzE1DArtjbQrKYroUhV0Ogg7rdaYuoqoILV53PV2ReZ7HgUuhHMTkpG7xvvkf+CcZVvC+IvRwQvZ7rCCAKMb6eph/iEpr5qwJ8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR21MB4704.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(38070700021)(18002099003)(4143699003)(5023799004)(4133799003)(11063799006)(6133799003)(22082099003)(7053199004)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TDk0AMop/KKjYKIqbXjunN5s12MyqHqiNCb2QqSO1cB61uOdD3KndyHlVplt?=
 =?us-ascii?Q?SkQvhzZj7Afet0/KrvGtlYiXnIFDgo8OMhjzeerfhBisixGam2Do6EJG3+4i?=
 =?us-ascii?Q?6QNeUxOfZR3R7t9VpTFazw3u6vyL4DbuDm8OXLqvUz3LvutqSqOdVvZhe51L?=
 =?us-ascii?Q?E+7oeM97qROJ9cqXe2ieJLwAkjImbkd2aEQkqTT2xHAdnXCdZvIB7+diCfQ9?=
 =?us-ascii?Q?7iiRCT6biQBG8kC1Oac1rD6BXs2R7IGimjkGeSAurA9LWtZjsHbUNSTfFmhS?=
 =?us-ascii?Q?JTzxZHGE+4UBRi9nDndN8djmNRfZV1ba1FlpJPp8Akp3gqR9aAJbfBwc2jjk?=
 =?us-ascii?Q?MTeRROVssWo6W3em1TLYU8GFjZ4CUM7cVlo82qne445Mg5I3qmi77dLrbcN/?=
 =?us-ascii?Q?ONT2WsUhqHP/E80FzhKlZ2zO418H1jf840pA5K1cntZsPsa8DXw1R9yz0MF8?=
 =?us-ascii?Q?h1CBHWVKe8l8aCtVBd9XohLNm+Uw6OmvCMNut8h5N4wxorqdOYFME6ybUSQO?=
 =?us-ascii?Q?vUnjwhNwbL3rkZPfRO6K4w5vjbLJu2aAZPrDqMytq+wnpHRQIrq2C011EB/j?=
 =?us-ascii?Q?JKITI2zm8T5K74DQxKT1Gn6RwC73NpCyZMS99bGkh2M3D0OuyaurXrb8TF+h?=
 =?us-ascii?Q?1iBCzOzyWwpckc+f/zNKyl6wyz/XOAGKK37nKnDgYxvLPyz3/T9ddu2FP4I/?=
 =?us-ascii?Q?wtDE26rRHH6DFAV8JtgfXl+qqY3yiOuK0cJtpAl9KC8dznykK0SSeFLoY+0j?=
 =?us-ascii?Q?JOLTmFSXXXOaUOdfb2MlswA7m1MRPq7LzQaxIwSfu0Znl81wBBzOzIn/o1ur?=
 =?us-ascii?Q?x5YJ4lhxhstxPggx+nlDFIWEILy5z6m8fbQpu4GkjJLTViBE4GxfzoXORVuP?=
 =?us-ascii?Q?biZKy7svqVm57jO2JSRRhqkdinXUgHXoGxfVTplkQPncOLoV8pQFgAcIeJ03?=
 =?us-ascii?Q?BUpfniTHlHk4Ry8t8C1FNCWIc5hyI7aiiAE/054Qr9aH7m83GDyTYARnpjx+?=
 =?us-ascii?Q?unu21+iIfMJPUKuINf6/zTnSlod++WyzCWnc1Bgr0MOB1WYwucATkfZvUg8b?=
 =?us-ascii?Q?iKLIHqVYwgDCHF9N6hZUdCTXX8q5yR1df9UImkGRsJOOPHz9MKN5M+i/C2J5?=
 =?us-ascii?Q?kDmBuDQMipsTjvjkZbkbkEbd6GyIzGg4eJvZCdRdxs7cxQR1k3+XjskamtA5?=
 =?us-ascii?Q?n8TFjmdPru/SWIEi45YGtP+SImML+eRqBTM2YrYLLubY2mSsjtE30ZKCljh5?=
 =?us-ascii?Q?/1J8HkanqVSe7jXr/7Ex+4EdRPq95DaqklQtEBlrDiAI+fyscIJslEOvvJC1?=
 =?us-ascii?Q?2lY06ksYEm5oH3zw8kLw6/aMj2vsaINBSX7UszuNRd9+TQNEcMASOnlVjeXa?=
 =?us-ascii?Q?Ss7WqxyDrsTxIRjHbfuv8qkE/rM+78KaDf4gqu8+hezJR8UnIsojBUZ8cqY/?=
 =?us-ascii?Q?SYIWIQzETrodHEddJyvvv3+eLQSYPCaIu8sklPN1fsgytsA46YEnnmfB6p1P?=
 =?us-ascii?Q?v3YUYWOxLwJmzuNvAJIxN8ZivSDQq+w2rTqZdglKF76OObSexDGH+7c9VNvZ?=
 =?us-ascii?Q?cJnZe4qudhadHxn2DBIKh/84Dv5Xt3GxWEBz3b7JvZVQU73BUe+0CvpGDcXT?=
 =?us-ascii?Q?k7BmXIx6EmekB2qWditHTS4BSxkoWnt2C3feRpWTV2F/Y8JMFLt2ycLMd9F+?=
 =?us-ascii?Q?5Vy1AZmysYv8eT4/JxWpT72wO5+B8wyg4bHFGt5Sc0ExxSN0zOaIVonRRQ6t?=
 =?us-ascii?Q?EvJosCOl2A=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV5PR21MB4704.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bc621f-41bc-4d7a-0823-08dedd32d1e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 20:52:27.2336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Anh9AJmpmHwnR9QajDhBny+OG8nnAp6ZFTmWQFwJgd7iq9bNNr3oFZfjROnWMpJyp1/YBMEZkbf1PdjgM+vUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB5137
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11876-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:shradhagupta@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1D4672A58B



> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>
> Sent: Wednesday, July 8, 2026 4:09 AM
> To: haiyangz@linux.microsoft.com
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; horms@kernel.org=
;
> ernis@linux.microsoft.com; dipayanroy@linux.microsoft.com;
> gargaditya@linux.microsoft.com; shradhagupta@linux.microsoft.com; linux-
> kernel@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next v2] net: mana: Add handler for
> sriov configure
>=20
> From: AI Reviewer <ai@example.com>
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsashi=
ko.
> dev%2F&data=3D05%7C02%7Chaiyangz%40microsoft.com%7C27add93a1c4b4c0c7b4808=
ded
> cc833d4%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C639190949593984694%7=
C
> Unknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJ=
X
> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DqLm%2BrL1nE=
F6%
> 2FlF2%2Fmed2mnc%2BVR4Vp9P6G6i5Im1PquU%3D&reserved=3D0
> ---
> net: mana: Add handler for sriov configure
>=20
> Add callback function for the pci_driver / sriov_configure.
>=20
> It asks the NIC to provide certain number of VFs, or disable
> VFs if the request is zero.
>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index e8b7ffb47eb98..f7a79874fd0eb 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -2496,6 +2496,20 @@ static void mana_gd_shutdown(struct pci_dev
> *pdev)
> >  	pci_disable_device(pdev);
> >  }
>=20
> [Severity: High]
> With the addition of SR-IOV support in this patch, do mana_gd_shutdown()
> and
> mana_gd_remove() need to call pci_disable_sriov()?
>=20
> If a user enables VFs via sysfs and then unbinds the driver or shuts down
> the
> system, could this omission introduce a regression where orphaned, dead V=
F
> PCI
> devices are left in the kernel?
>=20
> Accessing these orphaned VFs might trigger use-after-free crashes or
> hardware
> faults, as the underlying PF hardware and driver context have been
> destroyed.
Will fix.

>=20
> > +static int mana_sriov_configure(struct pci_dev *pdev, int numvfs)
> > +{
> > +	int err =3D 0;
> > +
> > +	dev_info(&pdev->dev, "Requested num VFs: %d\n", numvfs);
> > +
> > +	if (numvfs > 0)
> > +		err =3D pci_enable_sriov(pdev, numvfs);
> > +	else
> > +		pci_disable_sriov(pdev);
>=20
> [Severity: High]
> Should this path check if the VFs are currently assigned to a guest VM
> before
> disabling SR-IOV?
>=20
> If a privileged user writes 0 to sriov_numvfs while VFs are actively
> assigned
> to a VM (e.g., via vfio-pci), could forcefully removing the PCI devices
> cause
> a regression resulting in host IOMMU faults and guest kernel panics?
>=20
> Would it be better to check pci_vfs_assigned(pdev) here, or use the
> pci_sriov_configure_simple() helper to safely enforce this?

Will update.
I will send out an updated patch soon.

Thanks,
- Haiyang

