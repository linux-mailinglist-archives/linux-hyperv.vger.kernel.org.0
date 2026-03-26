Return-Path: <linux-hyperv+bounces-9801-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFblJetOxWlH9QQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9801-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 16:21:15 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DB3377AB
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC0BC306E064
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9837283A14;
	Thu, 26 Mar 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="irUAyFQA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020106.outbound.protection.outlook.com [52.101.56.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E23FF8B9;
	Thu, 26 Mar 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537475; cv=fail; b=E3IYRHTr3YSjeSYOg5j/m24ApM+UH7Y32a7BK0wnRmt4Mpws/jVzDVoqYS8yyWi+Tk6SnV3avplqdVB9hkac4yo4Wmwn6FyMppNAYlr1YSl6SZWvSB1TH6BQUSOT0ccPOLSZ7fJFYFJk9E+x2jdMdbic/+iJg2BHviTNZId1ynM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537475; c=relaxed/simple;
	bh=40PF6aYl72TluClOctJHS85BMGBeSkF4YIR+BDu22MA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c7yCXkOFZc6dWVDNhKVMFflfGgvVcYwsyfQz5GI4CPWzG678Nr/Je8MF9k3Q72nhqEEu3A/zgwhSGUzX6u/LX4HSNuZWO2Sr/bqJMTAaj8Dj6SLPoIJIYwT3fkPTU0ClewYqrdnwidpBslG9kmodObCgVt3B9o02xZHPyfgQcis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=irUAyFQA; arc=fail smtp.client-ip=52.101.56.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBvkbBWDHfmCLotqQSNk0IqlQHg611wQSOcdX1t4mvpKESMAFFClwp7OAqrPaKwCi31yTVrwwmZI+2+I/CCI3Pzzgh10VB82piY219bS2uo06KCv4IV8HwxMqeGIvj83Fl3lHT2/1CcK+yvlWrQT1Z+rjlygWTIWVdPn0/SvO2mhOtNr2leYoB0U9VPRAMwQukefYbJo2s6bLVKaXpK9m1xu9hQk6GaqvUsCfoB6WE546JE7XXUINWff//HuVWv2GshkCJqx0HcrCRLYApFksBf7iMjQz0AZGjoUtOpECFMxbtXwwUuppssNf+lZsjRqYPLHAFEeTIHqtzxJfdCNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuQ4erPD+b47Nxw8GS0w/rh2HRjg7IDGNmKirHK6z5o=;
 b=H7vhQpRg1RWtg2OmT3iCGNyOj5fZoxmbGzoVT98PE5SrQtq+Kg9B/XrrvWwnzg0QZ0FIi1NbWIuM1PIY4ua8+U1W2T5rqxeyeTb6WbLb6Dt5Blpg8hS6x20PXbKFHev7FLIGwzITqhHHwWKy67CZI+6OERH6K0aEFFbPYcxR1UeoVKtHKCThFCA7efnbMITnNCuy/iO7TZzI6JqkBY5n0JQukqXtdYsTe7Yivt773o6ZemRk7VHSqNl9fKxDRTg/MjhVPnNNkEGqc9rMpQ/iYZTBGlt4aH6F3nmqei+fj0JKyrcoU6Kob6T1f0SC1lWMgpVBKZXm7eMsDwXLLp7Mnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuQ4erPD+b47Nxw8GS0w/rh2HRjg7IDGNmKirHK6z5o=;
 b=irUAyFQAw9rmhVHOKp+z14kkdZOj7a+tS5736iQ5swNWSYbnuRxH4+HXZmt0azS/6hv8xex62E8qxyNn5+xMs05iDgS1JdnOoimlml5t2GrZw29jnccxTlaIfw/0wMHBqsI5W73dxG2gaeXowtmvxTgH2iCivBPDBni1q+Yor6U=
Received: from BY1PR21MB3870.namprd21.prod.outlook.com (2603:10b6:a03:525::7)
 by LV9PR21MB5406.namprd21.prod.outlook.com (2603:10b6:408:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 15:04:29 +0000
Received: from BY1PR21MB3870.namprd21.prod.outlook.com
 ([fe80::9faa:4fb0:486b:8267]) by BY1PR21MB3870.namprd21.prod.outlook.com
 ([fe80::9faa:4fb0:486b:8267%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 15:04:29 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, Dipayaan Roy
	<dipayanroy@microsoft.com>
Subject: RE: [PATCH net,v2] net: mana: Fix RX skb truesize accounting
Thread-Topic: [PATCH net,v2] net: mana: Fix RX skb truesize accounting
Thread-Index: AQHcu7oS4/BfnrhFE0utJ7wjdSrUdLXA68xg
Date: Thu, 26 Mar 2026 15:04:28 +0000
Message-ID:
 <BY1PR21MB38707172B2F76688C6B28252CA56A@BY1PR21MB3870.namprd21.prod.outlook.com>
References:
 <acLUhLpLum6qrD/N@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <acLUhLpLum6qrD/N@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=69808163-55de-4379-9325-9374dfe3c29c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-26T15:02:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR21MB3870:EE_|LV9PR21MB5406:EE_
x-ms-office365-filtering-correlation-id: d39cdc08-b6ca-4b83-80b8-08de8b48fa84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020|22082099003|56012099003|18002099003|7053199004;
x-microsoft-antispam-message-info:
 16PVDXv2RBl1mYftBNJkXHgKwkHIxmqRJaAcfLF/m5YQyVC10ddsxVu/WAg013A8chFIi2YBWqpXlJX1w8w2aQl5Ej5H1rJXZ5T03X27bs4ys4NzbK5HRcNP9ivNmjlT646OZgQ37/Yj2Xae7tcRmTa7fQ3SrMIaWZdyzlBAONnU/Sgywj6qkSh1RTq4oiI+U9eEiFb+CjCeR/sy3SQ/SfFzev4I6nnYoMVmd9OaEiWjr26P8u1KbFo/c8cG/EFCP40ekLOCFRJuD3DSpOhyY9ovg5008ICFdptsDPFUGMH4Wuv0vHIvIoXS9+jufbujRNWiXzIyvgpRw9gSXv9zxC71/6ATQ3jVIGYUj87paz98Qo3yEy/omT0+bwZb8itl1Se03vIavFUyj0qUtw7aj+HD5asQficYcaEN6q8prxyj2dJ96g2CYChbaiZjH/qApfr0dER28dQPjDnYMpZ0UnFIqpZGkxsofsz1pCyubc4X/fCQEulU3Om2/+LPDU04vVbYcf5G4ERTDq9fYbV0CAUFNFn0NVUwIlv2PQDKjF8tU/SAo+3QNz5tvialD/mQI7Yzg0nPlmW6QdvFXoDWs/u7oNVvinvvio2Zq1F1Y7XdfVaGUEoisWzkWipwsyadO7yF7BUJR4koqrp+kAEDtmrFGOKZVKsx/KNMy3hKQHBh903K8/p/Z+EC5jmJa/kOghP++Uvlao49kHQ8ThYifoG8kJacOFYmCDl0lubTenrmheL/wIJM7SOeH+VVsoFlGZU0HFY1K6/31lQ2LB+NptbX0Tb2ZDX/PQf7FL4LcONxP9THSjw1oTkRV4QuTH0B
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR21MB3870.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(22082099003)(56012099003)(18002099003)(7053199004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NbFeU7LJFHgQYOD2GiuQf/6HdfBTssHdLBGtFSsi/oV8vrROYmWPeWHZpd6t?=
 =?us-ascii?Q?F1XEOpKoVvWVnAIndy1cxbvPkTVPnASAIfyWEIdzlCSziS78JPVHgDigj+gC?=
 =?us-ascii?Q?mv+ru2U8gtTkiWQvio1Rcae6ss92woXdm0DrI+q3owEFOixsOHvdsh+jdSkW?=
 =?us-ascii?Q?lU9IbQltFmW9LtKsy/7jokPWl/d413uyBmPlE+MJpqbNy9R8go9kqy9U+f7+?=
 =?us-ascii?Q?Y5g+1/FL2sDDIWbhakNwfEiBFsL5lz7zpMLW3oUFdUIMx8v3alR0dvB0FZTH?=
 =?us-ascii?Q?E3hDXKSVLLeAaduXqKHUz7FuxwUdPkPRFIayp9pbqA6dbnRFt1cEndwDp19m?=
 =?us-ascii?Q?EQdYIgOrA3Y0gSRjG/Wi7GQEm8uVSy9mJCO+2dfYnUFvsrdSQAIXTuoWn0E8?=
 =?us-ascii?Q?Yb6g4b/bpOeqMmwg6loWQSpaHK4vRuwNJ1JX++5idnqgW/+NPszpvndfR1nv?=
 =?us-ascii?Q?wm4jDuZGRmDWtj9xZVkbiiaqgb4MZjbWRPy8lpy85kvpIFPjQlDKCChj4hUb?=
 =?us-ascii?Q?7cmaQtwx3aap5WzYhbkIAb+SDbjhwUTU58QPijxdYh4BV3U6LxiQsgz41jZV?=
 =?us-ascii?Q?klynxBjJlKLcfwtPd7XRAbE8Zn8Xupy/FtJXiuPtXv2KW7u4qOBwLAlKjkGM?=
 =?us-ascii?Q?LPYqh18WSjkJw1fRB7Xa5Bi3o0ncA+6iYzAVf1e/D/+ItTwx898b1WVY/mjQ?=
 =?us-ascii?Q?u1sfHAumpwZN4JkNcKeKWZsHqgQ4mtCPyh+dBNOFGLjIfDHHHpn9TQm6H2U9?=
 =?us-ascii?Q?/yP5NoSN2wwyBM/7FRSX9pr0w1V+SstcJehzJ2/f2eXfG688eOlG4GL99vR+?=
 =?us-ascii?Q?kAMnxFiYYXZhzvZg1Z1xZcg0bSCQr2Rtv1iCKGmGY6jM+DuQtZxnNW3r3dtC?=
 =?us-ascii?Q?adJcakJCzFGyT9C8wijMdPF6M++VBOQTj7kliNjGTmQUn01KrLk1W6ZCiMbC?=
 =?us-ascii?Q?+w/W9HIFjNyhEgVjATVFtllNtrzPQim4uyUKAFPo1D5Nb8zXN1GsnWZ/1J/n?=
 =?us-ascii?Q?qQOAPKTeckDdQCdzkHA+Jv8+4iUL+p4zSzXBy7o0+khujFg4a49nCVmGzUSf?=
 =?us-ascii?Q?UummehYJ802dm6oza40GaqfoYaXHY/Cgq25G3xZDUQ123rqndrCEKmp1ywvD?=
 =?us-ascii?Q?PfhFGcmUjz+1AWsaKkdmCd9B052za1cUAoInm6xOvYGEJYLJnGugyN1yYT45?=
 =?us-ascii?Q?UeP9tsqPfGL2L+h7bbdcBJf7doGCM4kF9EqGwFVJL1zaTlGokdp6sENmoUzE?=
 =?us-ascii?Q?02BysioV6fqVrZ+jMd/7na0p8rPiULQt0uumP2RUj1bPZY4vX2iHrmN6+4M3?=
 =?us-ascii?Q?DndKIG4F2/2Sng4G0WbknIm7Vx4OFssXl/sRB6cKWfHRuRBaMdkbnWvGcG4v?=
 =?us-ascii?Q?oIJ0cEoBpHX/rO2Lsbw8kJoHXfNWWzIP2IQdiT+mTHvSoV2aIvORSd7OKoIS?=
 =?us-ascii?Q?fwyQ6aS2DHAGNKeKRFRZV8chO5SNeyi2B9MFEkd4MSWkGeBzZGXU7TwSC6+x?=
 =?us-ascii?Q?VUnKWbaYoAaVdcOhpRa/DbJqs/DBGqz6wweCpyhfjiYJOJFz93HGXfaJveCI?=
 =?us-ascii?Q?ubksrPMJUtcLyLerqhW8KantITGmFkkMuqKBo6tRckQp/1Zw/Rzh6RgJJm2p?=
 =?us-ascii?Q?qe4MsuejjB0ceG/BSr9Szc9biEfPAp2UtdD6A9ggRsNMl5P8dGiUAajYFlMF?=
 =?us-ascii?Q?2MS1ENSTCJldvBkjjXH0D4FGXbzWcfB6gwxQ+SlpoGk94FnYNaGCNW+ErPHr?=
 =?us-ascii?Q?/Er3HVJn4A=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY1PR21MB3870.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39cdc08-b6ca-4b83-80b8-08de8b48fa84
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 15:04:28.9885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNfEbVSyfA6NHG54scVvL1iXvGOM/5BUE5OWwCcWPedrvCDOUFfXoBGyOa/4QYd/3x+vXArDe8br/4OqPaNWrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR21MB5406
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9801-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 767DB3377AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Sent: Tuesday, March 24, 2026 2:14 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; leon@kernel.org;
> Long Li <longli@microsoft.com>; Konstantin Taranov
> <kotaranov@microsoft.com>; horms@kernel.org;
> shradhagupta@linux.microsoft.com; ssengar@linux.microsoft.com;
> ernis@linux.microsoft.com; Shiraz Saleem <shirazsaleem@microsoft.com>;
> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
> stephen@networkplumber.org; jacob.e.keller@intel.com; Dipayaan Roy
> <dipayanroy@microsoft.com>
> Subject: [PATCH net,v2] net: mana: Fix RX skb truesize accounting
>=20
> MANA passes rxq->alloc_size to napi_build_skb() for all RX buffers.
> It is correct for fragment-backed RX buffers, where alloc_size matches
> the actual backing allocation used for each packet buffer. However, in
> the non-fragment RX path mana allocates a full page, or a higher-order
> page, per RX buffer. In that case alloc_size only reflects the usable
> packet area and not the actual backing memory.
>=20
> This causes napi_build_skb() to underestimate the skb backing allocation
> in the single-buffer RX path, so skb->truesize is derived from a value
> smaller than the real RX buffer allocation.
>=20
> Fix this by updating alloc_size in the non-fragment RX path to the
> actual backing allocation size before it is passed to napi_build_skb().
>=20
> Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers
> instead of full pages to improve memory efficiency.")
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

> ---
> Changes in v2:
>  - Added maintainers missed in v1.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index ea71de39f996..884f8e548174 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -766,6 +766,13 @@ static void mana_get_rxbuf_cfg(struct
> mana_port_context *apc,
>  		}
>=20
>  		*frag_count =3D 1;
> +
> +		/* In the single-buffer path, napi_build_skb() must see the
> +		 * actual backing allocation size so skb->truesize reflects
> +		 * the full page (or higher-order page), not just the usable
> +		 * packet area.
> +		 */
> +		*alloc_size =3D PAGE_SIZE << get_order(*alloc_size);
>  		return;
>  	}
>=20
> --
> 2.43.0
>=20


