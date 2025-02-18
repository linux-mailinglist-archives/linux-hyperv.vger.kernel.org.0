Return-Path: <linux-hyperv+bounces-3963-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B4A3AB5B
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Feb 2025 22:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376BF173FA6
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Feb 2025 21:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A41D7E21;
	Tue, 18 Feb 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="d5r3R6Rv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023120.outbound.protection.outlook.com [40.107.201.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2D1D63F1;
	Tue, 18 Feb 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915504; cv=fail; b=HKb6Y0oW25rZJDRRZkkG9bab8LTXaPtQeGiinZQ9O/UDXwGs7BaRyknmcL0XnNQoJpYUnDmgTkCn8dHhuuFLhehTVdlapA8Ohz9dwq+OJyOaItaV3/breOOAUUDnpQQu2NucZeC/Lyu6sMmpUwANT0nvnkMLJvym4NqwkqNV+jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915504; c=relaxed/simple;
	bh=dDIZ2ZXjOZygOx6cDjYgW4ZSMQ4HEKcoOB43qOlRFnc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ae6hlhhAJ2Y8U59Tn8WoptqvHiVfrAhnV0pHnoiOviGkBbW3i2k81YkcKiFaclWvKeIey5hKZNjpHyhYkw1SpeVGM8t4mVKsJHBIPPW6jzIjlrL2BoSiVhPW3o4y5LY0tGXttCpP2qfva97XR0mMDvzQ3XAnoMy47nWFYy3KXFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=d5r3R6Rv; arc=fail smtp.client-ip=40.107.201.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAIyRlU25KexjULF9BM2hDrJIXWG2Ws3udjtvDG/rIE23i1Ag4ngYiJxN6XOaDgGyye4sJjkk0x9pigefRA5hZAZZpbSNPrn9y5sbBXdtUMbZnFGeKwMVpp+4emZLsqgKvSL7chIT1tbnUkS4BC8t8iJqgbnJ1hDUfl85UPvfiRXZFkoXK1NY9qMPZZddOH0wfLnwCU+7/RVO+3pja+PtwC1PCF8YEx5yo8YyqtlFGtGqCw/3VaQF228uQEMpywsaOzebbn3BqXIWhJexleHWD8wZcP+Tdshof/uTNN9Dg/rwwDf55FkC5zLesX4qkmHTgcmrloXanrFv3P1i+L3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxwccjeoDxaWzZ5tJ8jsTILH0HYH2IvayzMJ6LWuoO4=;
 b=H7w1X//3C9P1yDkXtF3x67MXUZOGuG2pdBV6gQVI8bB/jrrswfK+mun8hf16XLGsyLlxXpEehOkOhG1E1+AfJHT+arDZGaMNIGlRVbvOJwlgGbTPKnc0AcNXG3kxyRuFMPqb656/orhY/7zqFX9nFYhtzu3yeFz0vCsVf1vlvPg/5NbvCWnWMSMgdknq2+OXQuBaBEWoQA8WRtDjkusAUeVHEcfAtEgkmfNo3GzPsozkWOB+0yhXq7ATyk52g4i4fACmic34NsC7l4tQE0KfSrukFaZQAkQcWSR7LM/xc7AzjfMmBc1Ok8qX7Wi3Quw5do76lZmAWLWxpkmi5II8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxwccjeoDxaWzZ5tJ8jsTILH0HYH2IvayzMJ6LWuoO4=;
 b=d5r3R6RvvA1JNh4Eq8dfgsMg2iGo2oJZ6npuSHvEa3zcmPI7BeSonItojJ3DBbfEDLZto/gn/lSiEoAp3OFJRqd0NO/+FqotDTRPiMDs9SQQoYv3sEU6YiVofI9i13Kws4cWMNt11mAlUAif8jyPtduEbjqRjx+X6brys+gQ8Jo=
Received: from SJ1PR21MB3432.namprd21.prod.outlook.com (2603:10b6:a03:454::18)
 by SJ0PR21MB2037.namprd21.prod.outlook.com (2603:10b6:a03:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.10; Tue, 18 Feb
 2025 21:51:38 +0000
Received: from SJ1PR21MB3432.namprd21.prod.outlook.com
 ([fe80::9fe2:ba5d:6491:db0e]) by SJ1PR21MB3432.namprd21.prod.outlook.com
 ([fe80::9fe2:ba5d:6491:db0e%4]) with mapi id 15.20.8466.004; Tue, 18 Feb 2025
 21:51:37 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "schakrabarti@linux.microsoft.com"
	<schakrabarti@linux.microsoft.com>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, Long Li <longli@microsoft.com>,
	"erick.archer@outlook.com" <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: mana: Add debug logs in MANA network driver
Thread-Topic: [PATCH v2] net: mana: Add debug logs in MANA network driver
Thread-Index: AQHbgaVHw2FOXk8MCkypKfAyq6KTQrNNmxtg
Date: Tue, 18 Feb 2025 21:51:37 +0000
Message-ID:
 <SJ1PR21MB3432C6A1B35542EE6E87F248CAFA2@SJ1PR21MB3432.namprd21.prod.outlook.com>
References: <1739842455-23899-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1739842455-23899-1-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=83e2674f-78b0-448f-beec-78df236515d0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-18T21:51:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3432:EE_|SJ0PR21MB2037:EE_
x-ms-office365-filtering-correlation-id: 4f1d7776-5503-4077-821c-08dd50666ba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|7053199007|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VI2Z+1IAPeRjxqneI6KFhdHX8tG+G2Lkg3/PbRO267SvbJK+oPws/A1oGktR?=
 =?us-ascii?Q?mIrxzgrWha8f9AuwdGtzpH1e7e8kYHlBKqhZ7ldbYePxuPoGzOhr0dSLuf2J?=
 =?us-ascii?Q?dsldjXyQHJ7dD4l6CcjPspVVSv6nA5oZukuZJjQ8cAlKvd/B/bgLtyDqah5Z?=
 =?us-ascii?Q?k1sUlucHfikn09cwhFMDyLDWYV5loIdks5+OlvutGexnYqqHyz42BGDcQThq?=
 =?us-ascii?Q?zrQM7R2kyurbId+lfnks3LV1QNLsqzTlLePIr8LMEHbwW8ciwWwzWxKic1Cg?=
 =?us-ascii?Q?CU7d5zThYR4oSmEcUG4ZKA0MC+TvmoDLWj9+SZ2tc0goOK2egRoZX5zpiRnt?=
 =?us-ascii?Q?XbGNEnN+AqQrXFgbmzRA+vqx9Eln8utSUWp9lssaysQKwcGZ7Jykp94HT1Z4?=
 =?us-ascii?Q?yXq+Uy+1GqhV+LOHXoSFTxAJXaueLd6y1fg6Y9ZW9prHJbfjzuAm6Uuf7bdA?=
 =?us-ascii?Q?DcYwm5HGLlkQ9/Bdocw8C3/Sx9e00fKclk5rtUcLD6wEG+WbVhHcrzhlp7Q1?=
 =?us-ascii?Q?Awm7FgAtYABY3t1wWry7S71Csr91qPwZrtfhkjpgUmDMWcE7mfr/gQoMua4c?=
 =?us-ascii?Q?RCoqbxeJfO1jUK+101ZNuO6kIyVE3FoSXnKGB1tv3iK6GM7Wnfeosxe4e31h?=
 =?us-ascii?Q?YNmw9kTkXZzOf/p0f6D6we0Aa6USerkSW+nkONFPayMcnISCahJyWrJ9u41Z?=
 =?us-ascii?Q?E9ztP6qtUrzggrIBOzafyXm4S+tiiIAlgouCmtay8EWSZkvvjoVQsMr/iVAX?=
 =?us-ascii?Q?DfzW7jMX3TxxbbXM1YPKXVPgzLQ0d6VxX+xyvwqqeP+lqCek4VRemVkORI0r?=
 =?us-ascii?Q?QQP++Z31iQFCJmTkJ9MGhAlJAakP9KvITGFyNrTIGwHtd0cNxgv1z+KBX7jN?=
 =?us-ascii?Q?l+8J3WufY0MgE5Rv0w7RVqEDLdSf3DTdcv2RNxk9VBC8xRTjYYl8VMJ2BYhO?=
 =?us-ascii?Q?UErdVAflQKzIisJSxOg1bT6m9J0OfwsM7026QogCYNQMjaIwwIHQzvojjb1N?=
 =?us-ascii?Q?oTVqc6+o8Wqf+J1AINnihj0+iYZnuKq7LDrbf3J/9zXIqCywVWxZTmcFGqfJ?=
 =?us-ascii?Q?y1/mKomxA1XImZ2juYWdXOpC35kcFpVql3qpd3nrOGEl23R8VE/gz2M42AGa?=
 =?us-ascii?Q?NboTMzGs3Fj2oA+1sn7QGvQMrz7aBdbq6TXapFqE2BV1NJA/DMh2Z+LXi7xv?=
 =?us-ascii?Q?/ZAIgJ80lIP9w0JJR8y4b8IcFzD/oSsY7CqgNq5bxCrcnmPAKiKRNA3UQo5N?=
 =?us-ascii?Q?UpQM6yEENbziIIdD9op/vfeW8ffelNVSyBEx/uoLlO3A888gDzKxQkqYQcKA?=
 =?us-ascii?Q?hIeoHxnxfZwfTp1Gla/JTOxVfANmB9ChfuQ00hhZlVGegrGuafRClv1+ceUZ?=
 =?us-ascii?Q?dell3OZ7g62Ecf5StABKNruCvbLn107RekwHh4/QMaHnFk36lOOFx/nTvoEy?=
 =?us-ascii?Q?/duzEVTOS6cfmWtWaX3bT/nH3RfIkceu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3432.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(7053199007)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wtSQvu+W3ezXuqPkc7wm50VQ9cghS3g7p/C4Jx3Z8EYQnTH/g3PlYmY0leFE?=
 =?us-ascii?Q?5cD4Uy57tJh7RntdCuOnCeLnX8x0PwR3ZPdeZeELbFB6ryLnCIRfiyXJkrjS?=
 =?us-ascii?Q?r3LcAoQXNTy7pHFnEsThUKRu3D8JocS815tmHKKR1IJ/1RMIAgBeDCuxhb9Z?=
 =?us-ascii?Q?1FzjSnA8B57ElfpKMogV88qczycC8GP/k1YVWLxNmhRn5jNuB56cpES7ut8P?=
 =?us-ascii?Q?1IwGdB3cBBg9Mh7zMwiM+T98C3H2O5Wb59T3274YzapYsPkOkmo8XO7OUwH8?=
 =?us-ascii?Q?cty8g7QScYXm3i8CUSKTtK5nkbrqAsHE9oSGGqTvIS0jBZM6Rqm92n45y2TH?=
 =?us-ascii?Q?/NrXB4f8URc291+n3BGS/Gcm0vAGvzKRRcHHLdNIuYpd/edRIV22vLIIPYGs?=
 =?us-ascii?Q?OWg4VWr2alfhh/TbRAQTJXDjCZGjC+YgfSYC7K9tv51YBQrzD+GyVh68UipM?=
 =?us-ascii?Q?YimaP+mu4CdRSo8aCe6NbuzfbABQvrJokNlKOw+qEvCEEVYOq+zalxrbCqAy?=
 =?us-ascii?Q?9F3UIWjByU61VMcCGNxM8OtdPrLTTwGd3ZvQ87NN4QPYLkpZYkKHaOqBNtEV?=
 =?us-ascii?Q?UgZIKgGB7xCCfxMudufNXbb5C6OdtXV4DvH9PnEknM1EjR5qy/0WFajsatzs?=
 =?us-ascii?Q?/ekbzDiJRWHtBzkzcMXepC8xqXu6vZT67E99myqJ/n6jfJLyLlLSLwiTx3QC?=
 =?us-ascii?Q?9DOAHm+Pf6UTgWiFDGFw3ZiVcb7IUv54WN0E2EN09DUre7NiAOcwid9Vy0IP?=
 =?us-ascii?Q?kJGumXng4lhPFuBzSy83g5+28eUCethl03+2zUJj1Iw0eqosJMRFxmLHmNcM?=
 =?us-ascii?Q?aR6wukOFZxlkXT85aIbt19bJjI28MMq/C5WIZ/slXdc5ZAF1387OAGWoSyDo?=
 =?us-ascii?Q?9Rq2CKPxPoX50zJ8CkAh07mP+uPcbtA/FS8m7SpDH5l9lmbtx4nezUt9T+hm?=
 =?us-ascii?Q?ku8RK+mI0Si7FjE8ufUBEgmz2lCwx31CpO/QwWVRiQcjhejKgjauFrbnLYff?=
 =?us-ascii?Q?VF2wqorl6CTa4pGFx/pZzthJDOwzTXINjSQBzDx7gonDoXeDa1tL9zJtZoUM?=
 =?us-ascii?Q?fDYn5ZxNDA9mxmr5e78lzVL4FuGRvKDCH6DqdcqNeisKpKUiBRAWXe0O1b28?=
 =?us-ascii?Q?6UR0uXqVknsr/cbS/GYagU6oEQ5Y3mvJZ5L0HDS0gyQUlFzQFTmtqRviR5ob?=
 =?us-ascii?Q?m0F8d818ldMJNvg3enTQKbKqHI7lirucR82s+BVCmixGLgsDRd8nclpC8DaB?=
 =?us-ascii?Q?9F5uaq7c3mhQ90PcJw3iWrWoG2udTud4yKJzfyjjkQ/ddhchlHjP0bYo1jzv?=
 =?us-ascii?Q?07+XiferquQ/+Jt7lTCmpAZxD6BVrywW2LXCa9o84ZjL8icCmOs+dYUr9fFo?=
 =?us-ascii?Q?uc5jSyDfThqyUL8V2SWjPwmM0tvIXgQFHQ8zb6OwfNfbIiHs1cfbYxA+LuK2?=
 =?us-ascii?Q?rVUITR97zYa6iZfGj+kXDseHygeMyg6XOigTkSVxcVhyLDOceNJ4+YuEnAii?=
 =?us-ascii?Q?JUqSwfEwFXBmL9okEZceGNqqkGT5JZYey072+du1R/O8ZzXHcvC/TrvymYeC?=
 =?us-ascii?Q?sopCMQ9ZVGALRplwaYA5/u4dwUZDjBrEwHWggNPn?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3432.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1d7776-5503-4077-821c-08dd50666ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 21:51:37.8920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vABxj0/9eHgB3uTPSIk+1tx9VylVSN+e/sV5MibRbUi7B42hQcVd0YRonYQO1eLpAbqR04YgJU6nHSPtOvcOwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2037



> -----Original Message-----
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Sent: Monday, February 17, 2025 8:34 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> michal.swiatkowski@linux.intel.com; mlevitsk@redhat.com;
> yury.norov@gmail.com; shradhagupta@linux.microsoft.com; Konstantin
> Taranov <kotaranov@microsoft.com>; peterz@infradead.org; akpm@linux-
> foundation.org; ernis@linux.microsoft.com;
> schakrabarti@linux.microsoft.com; kent.overstreet@linux.dev; Long Li
> <longli@microsoft.com>; erick.archer@outlook.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2] net: mana: Add debug logs in MANA network driver
>=20
> Add more logs to assist in debugging and monitoring
> driver behaviour, making it easier to identify potential
> issues  during development and testing.
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Thanks.=20

