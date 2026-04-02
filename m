Return-Path: <linux-hyperv+bounces-9933-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEx5GkPDzmmqpwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9933-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 21:28:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D6A38DAA3
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 21:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BAE93022638
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 19:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6C3333440;
	Thu,  2 Apr 2026 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MRPhbb0a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020083.outbound.protection.outlook.com [40.93.198.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18246309F19;
	Thu,  2 Apr 2026 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157830; cv=fail; b=h16KSMw+vhzS/yMba/whQDLIrlzP9GprAbKxqneRQAxqhrPpE+aT77+8IpzeBd3VekOhoKJ6+DcTPGSZ+M0UtRkz5OP5FIGtA12e3gEk4Miy7s+XwhQCRDppopD1esY8GhdcX0DtqVd5WmIJx+QC7F1Lqzy4NPlfY3Sl0l/BJ1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157830; c=relaxed/simple;
	bh=eoeWapXIu0auWilpW8kVlheoNGdKVL2g0GgPhO+guiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bMjzQkDAOJg6PkCoIpWVVc8ar2AKZ7pTrSYLXUWZZjLO0ua0UGk624/cI7r6/uz5cgTLTHUABX4vEYV94egU9R7gs09BHUqOjlZVmsceyP+i4wTwxGiL6G0Uf40GNHtlYMr1JEzfHWI/N0A0Plm0Ol9KRbbPPnnSVo1FbM2XO2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MRPhbb0a; arc=fail smtp.client-ip=40.93.198.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9FM8fJt80SRjIxLtSgRAjWziY6Z7YIdnKCHAUzg3bqCip3+MHSxwm/G4jcBe3JciG3QUSd/i3EPV76FcZ2cadtk5Io7M1NZOf8+vZnsJb5LagEIr2rfos4tvI0TJMm9oEFcVcFdVrA2uGq+asF0mu4X6MUHs01Oa39liEywVOjuAw/RuKTd9eqwDjJxdLwBaYkzFmqmS5xOKx4addT8ZoDJZsxSDLKv+Z4QwW7G8MBn9L0FapstnVv8ozSOv26pqxGE3wLCO1bgoQcd5orY3eNvH6WX2fUyD2qseWqlhAuf2ZHQhsQe15Ps9OaB93MHKq5C3wwzMsQglOAf8nAiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xMcAMwI0PX5s1iBOI28mgKglocrK0tXUrC6X6P6T3s=;
 b=aKPHCUGCLk7bMvUqs47bY0qEJfDxN6RIQiM4jqFtClcVnnNU20X2KermLeJZWhDYiXum/1WCrA7KONnujAHZtrzymb6MhTSeDnq37cwxgbNzsZ8oFeQ5qSGtSLqf0LLOFRi5iS1pnIsk06Y1tnpGKbPpciqswF/Pfp7LIOdwLySZgqAje4El2x/SKuF7aTpDeWrlse7Gka/QCnRpqPNBfbfpGsE+Bol1npTtXC8GwuuAzghi7xfurFAbUNHNk4E9lvoDfsXuYeW6zLy6Jt4nCeCKP70+X0tzR+o5u6+gXPVQktO/zvk9qCabmu4m3hpoHwjf1iT7eweOMNXzFc6mqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xMcAMwI0PX5s1iBOI28mgKglocrK0tXUrC6X6P6T3s=;
 b=MRPhbb0aXxDFfR0pAUW6r8UGfSDrZjhTBgNEtnLWh/DLNdsB4KIqK8c+T1cc9+5u62oKBOb52U0l7D0oKA+MlDerN1Jw5Y90VdPu5Td9pFpwqm3fgjTwydaROfsNAI/zN6rVRIzeF1p/V49ZE59MTdnYWuE05qCpkdu6yuNDRg4=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6178.namprd21.prod.outlook.com (2603:10b6:806:4aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 19:23:46 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 19:23:46 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Matthew Ruffell
	<matthew.ruffell@canonical.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Jake Oshins <jakeo@microsoft.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Long Li <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index:
 AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgADOvQCAABBuYIAAnjqAgAALUwCAAMhuoIBsfVtQ
Date: Thu, 2 Apr 2026 19:23:46 +0000
Message-ID:
 <SA1PR21MB69213185A6FE899BD2D4BFC3BF51A@SA1PR21MB6921.namprd21.prod.outlook.com>
References:
 <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260123053909.95584-1-matthew.ruffell@canonical.com>
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB415759DBA9428256D379841AD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415759DBA9428256D379841AD494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c3d0baf3-25b0-4af4-a6d5-a09e12163950;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-02T19:01:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6178:EE_
x-ms-office365-filtering-correlation-id: 256f05ea-3f5d-49bf-5b39-08de90ed5c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 fxlXesImIb3OBKo0BycGSet0ueWGRkbhI+93+xdfV7jmSa9I0d6aAwyzgltVrMlU1/4CQo9vi4Csmy4DOOKfr5PPTe3Rj02dW3ioTwJJdvjz0GQPsvLM/Fq00pFeIebbJfZ+idUzVsPUyXHd+UwFZM7M68Aac/p02buxJlBNNXvpEYfORKKbDk3Y6ybUHR2jzYJgY6zEjo79dE90AAoobp27D9ROpDcgnfAziFR8dIFR/VVVssycEAziHAmnbi0YPKP5McqlJ/3hz4wXIK6ApUXKEtdujkKYPSOBDNH/jmVqhkwV3VlcBs7uI3Jh7jONqW6b5NokabJE7UypqyIvdKNjHyHmAN1gMWro5jj4g+st9U0gH7oIXvF8flpfuausHSfXUuWjTkzG90MyCj+JT9FbNFkuBUJMODuIqZXiSz83qwss+/RAORiVW20GsF9lAks6VggfS50OT0giX4WpASPsOwsbLDSUE5JrODQb19m4cTIMWl+g94OD4BBGh7b2lEvE90n7WG7rtLrtV/sPVKXmXisfkhRSnFERxoQyfEIBLoxCzBo2/DgpZnFAlss7HHXPVZf0kMrv6uA5uZR1wXgLaYkGdEbCNKfuEiQpSvBE9OboxisW1m0B1WZA1Ct5ToWUFtKEVegGj9Ym1QVZEmL0MjMmQfgPHV3I0S9qnZjglwRSjC1ot3rXdd9fyqomq653KiU19p8C8bsxCenH/IhHCGs6WgtdX7p3yOi8hNfTaHMRHv0/nWcCUsBO6V8kYb0gKvutSMvY3qzll4oLtMdxQediUqsGzNOifxVt9t8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5w9iu/ZuKo+Mby6XFnL7tCtnx75n/MMDfyfRsWthy7OP5p+IsiyIcUnAP9HQ?=
 =?us-ascii?Q?4y6kGtQs0AHraOp6BHVVfNESfQflyf3ou3eW6rCleDlqj3YAAdyqMtECDGQD?=
 =?us-ascii?Q?JwmEL8yfwUjwARtNiyxMSXORH0j/L1M/jiWoH725hLYt0KXm3qLVXNjWn5GI?=
 =?us-ascii?Q?mgu9KKrIQ3fVYqVy5aqxOzYb424mHO81pUyDEzwRGGDEzPVTA+u1wedN7/1a?=
 =?us-ascii?Q?1GBMue49ZpA/x7nL7CHq+NOQMf/EBbAlxoV8w/GaPvt1qtqd48v5Kkbxfsud?=
 =?us-ascii?Q?NPujwlwRKFBwKQc20fHOqjeoE4A6WGZHw0Xw49KWk0ThqqJ4DagCinW4Vz8+?=
 =?us-ascii?Q?yewWumFavSLxzm8PLFa1JWzyKrnay/3O27SJGGurDCQ4ZsZoVh7jxYkLidqF?=
 =?us-ascii?Q?U/v4kwWNolNJxiTLDWTxM/EcrMKJHfm6MsdcOxZzllW/q2nR3IMoq7Eic6Ey?=
 =?us-ascii?Q?RFpCRryyYALcpNez4V0/Jw2EMpOrdhRKShJ8VbH985SUrctIDUwvkyBlh0Hn?=
 =?us-ascii?Q?OPz6nh+udceIj9z18E8Vt3I8YFG4pMmPgVghIXloe5Zi7qa8taxmkczCvcg4?=
 =?us-ascii?Q?HyD33YKwfNG8XrhqzQd6TNiH8l2aqq9HIuBKrDWlPRMsRYDSNd4FK105tHRn?=
 =?us-ascii?Q?7QtFF6M0kvT5JF9FU9Kt+MYr8JUUl0ilSgS3ghncV4phE4T+bpY23udNQSBf?=
 =?us-ascii?Q?+uApG+wpqSfE+l6ubitRRNXlL43/SCSR2Z82QTK3pH73bZcHxzfCmv3uSYJm?=
 =?us-ascii?Q?N7iuCe68Jt4cHwjuRsIaAwqCFIU0cl45LLguHDLo9SVdbOBCeQA7rnJ01wUO?=
 =?us-ascii?Q?8xFvR0Mge+U0g4uTyqRpbbG4KqSPeF3dyI5W+hErJD/g3L6sBm73KOP+kGcm?=
 =?us-ascii?Q?g7SCzCYKjoCnGF1qeZZadpjuXjI7ewtO7J1i3RTVH+DUnZwOu3ahe4N2LIW5?=
 =?us-ascii?Q?euD1sCZZp0WGzrrFCFnoiWQgUtG1/22twPQlXFK5kxPAexbF9nZo2SITxWsu?=
 =?us-ascii?Q?75Txpx64NAB9Ae/VnQ+chR3jMKZrNeIzRYvW2T5btDZ1wzRyYp7Dqs77jb22?=
 =?us-ascii?Q?q+FL6KjhNndmyS7M04rhE4muUrgomJXB0g+PQ+Qq2fgcgRFmmmPrHrJEy3y0?=
 =?us-ascii?Q?2h2G7ysw4uZQsahk4cf3qPx7TlF5vrUyeqL87aOfZnTQKHxNceg4/5MG3RgA?=
 =?us-ascii?Q?iPq1UtzBnTnkLj4zTlx28oBRdvqCVHOubUxKmGqvKr+mCsRBRQTd5Ao3OEd8?=
 =?us-ascii?Q?F0Meo+ZUIzDKOj/+OJ1NWS9cKvHfU8yzLQPRbAsMFsD72QOljU+4Xz1udX3Z?=
 =?us-ascii?Q?DpcsCGd3mw5jqIrwQvs7tEpncsfwVvH8fUtN4+F8nC0CHsdE3Q+xAQEQyxEG?=
 =?us-ascii?Q?eh2zcL13ge5y78oLPGTlMS3OLGPBE6YS8907vEpsqPmE5XwQvjJ7nG1xtwiB?=
 =?us-ascii?Q?9BvZLyyDGYV/A7WOlnDhs1z3hAGNVhyqdFHiigSknrE8xa/lXqXduBlEvR/u?=
 =?us-ascii?Q?6G08B0HNkODCDXmek9Fso5+kuLs494Y0Xa/WVhK732rt/mf+x94dGsF2guur?=
 =?us-ascii?Q?XNAzbD3gomCpYopvU2um4khvIWVCfElmvSo3/RtkVEwpxezYyqz/Ov14Mtuk?=
 =?us-ascii?Q?MVxrz6PeYbZRkYRFaPU2Fqen4ldr5zWp9YH+OwHGfXCku8MbLupc5rqeb3eG?=
 =?us-ascii?Q?u/G8NqPKjIWJxGKB7kDGdERP323jic62X5ymbUlIQMYF5ZlY?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256f05ea-3f5d-49bf-5b39-08de90ed5c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 19:23:46.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oVIdqIB5WlQz8anhPnN0xscVoI4+g51IJnrfC5/N3OeY5ZI74ai9QcI1unDCpsi4Uo4ZROLm8pdGt/ImZv1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6178
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9933-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,canonical.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: B4D6A38DAA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Friday, January 23, 2026 10:28 AM
>  ...
> One more thought here: Is commit 96959283a58d relevant? The
> commit message describes a scenario where vmbus_reserve_fb()
> doesn't do anything because CONFIG_SYSFB is not set. Looking at
> the code for vmbus_reserve_fb(), it doing nothing might imply that
> screen_info.lfb_base is 0. But when CONFIG_SYSFB is not set,
> screen_info.lfb_base is just ignored, with the same result. This behavior
> started with the 6.7 kernel due to commit a07b50d80ab6.
>=20
> Note that commit 96959283a58d has a follow-on to correct a
> problem when CONFIG_EFI is not set.  See commit 7b89a44b2e8c.
> If there's a reason to backport 96959283a58d, also get
> 7b89a44b2e8c.
>=20
> Michael

In my opinion,
96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests")
is not a good fix for a07b50d80ab6: the commit message of a07b50d80ab6
says "the vmbus_drv code marks the original EFI framebuffer as reserved, bu=
t
this is not required if there is no sysfb" -- IMO the message is incorrect.

Even if CONFIG_SYSFB is not set, we still need to reserve the framebuffer
MMIO range, because we need to make sure that hv_pci doesn't allocate
MMIO from there.

96959283a58d adds "select SYSFB if !HYPERV_VTL_MODE", but we can
still manually unset CONFIG_SYSFB (I happened to do this when debugging
the kdump issue), and hv_pci won't work.

IMO vmbus_reserve_fb() should unconditionally reserve the frame buffer
MMIO range. I'll post a patch like this:

--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2395,10 +2398,8 @@ static void __maybe_unused vmbus_reserve_fb(void)

        if (efi_enabled(EFI_BOOT)) {
                /* Gen2 VM: get FB base from EFI framebuffer */
-               if (IS_ENABLED(CONFIG_SYSFB)) {
-                       start =3D sysfb_primary_display.screen.lfb_base;
-                       size =3D max_t(__u32, sysfb_primary_display.screen.=
lfb_size, 0x800000);
-               }
+               start =3D sysfb_primary_display.screen.lfb_base;
+               size =3D max_t(__u32, sysfb_primary_display.screen.lfb_size=
, 0x800000);
        } else {
                /* Gen1 VM: get FB base from PCI */
                pdev =3D pci_get_device(PCI_VENDOR_ID_MICROSOFT,


diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 7937ac0cbd0f..78d7f8c66278 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -9,7 +9,6 @@ config HYPERV
        select PARAVIRT
        select X86_HV_CALLBACK_VECTOR if X86
        select OF_EARLY_FLATTREE if OF
-       select SYSFB if EFI && !HYPERV_VTL_MODE
        select IRQ_MSI_LIB if X86
        help
          Select this option to run Linux as a Hyper-V client operating

Thanks,
Dexuan

