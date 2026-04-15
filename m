Return-Path: <linux-hyperv+bounces-10184-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPwgBtDB32l7YgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10184-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 18:50:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0634067D4
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 18:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63E9631379D6
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D0B3E51DE;
	Wed, 15 Apr 2026 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Inph5Hj/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022077.outbound.protection.outlook.com [40.93.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83A3311C32;
	Wed, 15 Apr 2026 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271585; cv=fail; b=H3DFbpWlm4cxb6kcSQEJlZ/d8jssXDxqAlv+pnCR6QOOj1Wz9tlsOR1tkf8YOx4GAHG8he2ZOhjvd+o56XwnwLzj6y2LXOkX1ix9gGR5lImt0P8LQOWEBhICUMM07q8bvKqfN2IOqP0q/yA4dxTZqRTr39Z6Pwe1PNwGaUZNFWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271585; c=relaxed/simple;
	bh=NI6sk/0wY9467LJBNZFCh0nqtuJ+ru+ziw9FbMpXz8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tp9CMeTl7MTaVb2EMX0561tEO6nz/HVQ7IbUGhOuP0usNWHYfF04jrkwhfNiKhzgqNmAWDbvMZDe9/rFVbK/xewefbmSNw42xVXUhpO/bIii+aMgVbtoJZ8Ju2xFZuKEOKS64FtbdbvCes8BuKKP6dmfQ5i+wa8WuF+FZU8QYbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Inph5Hj/; arc=fail smtp.client-ip=40.93.195.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpb73HLDMfcVptJOk58oN19mq66kujuvjBFLcmalrTCTQmV7wMIH9iTcBSv4QgM6K9Fa4Fs75d/cSxjoz2DzMYtwVZUm0iGjgwEdEZu6AfT0C0RwOOwVe88PFPgEyJEteQsfhdvRFbwDgJBmjCaGS7JrQoRQdvNTSpWIW9NiDa1C1SMFMe1udCcrBtSs+YchyY2a6BVDXBoHu2qHClsH/2hZccUbafbU0Qe/FsQkTVwi1YLUlRs2ke+ebM6GIVX5g0Gn38ZGUyRn0efILlSWkB1hcQmr44fZQ85HCkDzShWGjXtg79Rl5yOjRFs8jEPfBDAbQ6keo4N5tp248ukCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvJnIg10CwU5NZfbuPat9O7j7C17KzEZkZlhtCzwvA0=;
 b=W/bjjSD8mpIGN8NbHM7G4SX5jYOnsjDpyzaAR0EXNIGdH0JhjlnU4UnlagDG8YF+Of1ByzppwgQvRMnbpfbQ1ZCcMARmD0XsBMZ5GaarAjTHQ88DT0VomBspMgZ+31pHMQ9OkaHducles+fXOj6n/2nlyBIQCLSk2qAg+ofAeJ0d3gD6V3F9Qc/r4WUV3dCYrX6qtqg//iku/7mJObsl1FxszhxCfZ8Qn/zG89rOZg262io0Iuj0fPIkF+ACtunkPf3EqxBs0mjzZTT83Yrx3yO5KTmTR3eWbc9kt7avJD9p5BiQsqtmm6rrB5CC2j+cigOg5SHCJW7KjhCQYkvjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvJnIg10CwU5NZfbuPat9O7j7C17KzEZkZlhtCzwvA0=;
 b=Inph5Hj/7WtPeqfoUbhd5ZxxZ6MBAHds+VpwkWtuk/VjyDZ/BoZBYnDp5alSe8E3RKselCvmykdTmx1b0tRrOz7ADmcWEe2gqsQvAivUGlnpWB9JZcu7kIF24Ctp3sS66FqzpBhKZPGnkDVatEgATi8rWD13YDviKt+W3ea32C4=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by DS2PR21MB4775.namprd21.prod.outlook.com (2603:10b6:8:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.2; Wed, 15 Apr
 2026 16:46:19 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 16:46:19 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Dexuan Cui <DECUI@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Jake Oshins <jakeo@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"kjlx@templeofstupid.com" <kjlx@templeofstupid.com>
CC: Krister Johansen <johansen@templeofstupid.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHcwvqZ7/kLR2JkdUmudlv9HY41bLXRHh0QgAOgeDCAAHmtkIAKqeRQgACBovA=
Date: Wed, 15 Apr 2026 16:46:19 +0000
Message-ID:
 <SA1PR21MB69219E8C3ECE7723E8880924BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260402234313.2490779-1-decui@microsoft.com>
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
 <SN6PR02MB4157D5C8EE35A221B130FC5AD45BA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=064ced81-0360-4c14-8a5a-ba65234f13c6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-15T08:44:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|DS2PR21MB4775:EE_
x-ms-office365-filtering-correlation-id: b8841640-80b8-4d54-647d-08de9b0e84fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 mcJs5D5fxcYT1d91FeMQCvFulAk0acRb2wZMzIR8rnf7KDZls1CLddU+cme3OJwseTAUu4eoMFBJa3XvYKabf6UsEsopfYn4AgAUs0X4kUpxHgs8TOU2yGPa9YBORnIrBUfxrgsm5lfPsPn0oDL9al/FQjlLvDGzUX7FyT/tYROLgFNZWw0EWOuNwMMQj+erf1Q11zqaqXBO/TLCvuMdLVAkgCa+3b1syAB7Rd2sE0rlDci6XOyOdTPqbcAW+W3EKWBFot6TkAWOiZxzQaKCZCvXU6eLi2efd0TV2JuVHvqLPscy0K8fyd3K43o1iUrTq0hgS+XwLyfqQYGmwkDlqanhMw9ye+zcd5NxdlLAJ1ElmKEmGcb846wRlNSLyCb7eY+pUamUjx1IS2py6wjmLq6XllzjAP25YDtcB6cTiTANwj0oG7VY+X58Bngmxc03gLA1oA1fK4a+se7OsQT8Y6DyednO4eKzRwZTu5GgRgwUW1rh+lHN1aK6jy2LRX466zoE0xuL2ljzGY+z5WUdveugw6WjKdh/YmZK7vo1LczWFu2UncjuasGl5UMOOjSEbLDIo3rDojYx1aabIcCchdQyFA2MY1HXTSDYkudTJgXA8zyJ0se5RyZfA8z9jHyXFk6wNxQ7hRTVoAlE8BJ6CKLTkO9R9tm4CqLPowF78KMjTItFsKrgJAC85P+0gUddxzubkX+/MTA2tZd0cZ/JxW+cS5QjZDPc7jKF/yZ1rQJEqAnqWnI3CPyEcWCxNaIJ4sJ1/vCQBt5MrmB6qjHXsYIdwIKAIp7qVs+tAa0GDPkdNw8IgsJFJ7+WFmrX/+k0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zcenUkOybyXmUdWp1vZeH17Zn9MBWkCSg0glsYdZnmHPN/i0sHZyexuGLhFg?=
 =?us-ascii?Q?1fOSWs/rT22TVJichNsYMxjt72mDomfQaVGW4YA8lO9AhaXV6vT8+PvPRktP?=
 =?us-ascii?Q?7gMSQICf9mW/jnxxrpA0nCCandjPU5uAmm3vzoNfTKafpayMBxNmyHXeAiLn?=
 =?us-ascii?Q?d6pii7YlhGjFHaZywHcnaZ+/b4TdmMU4f4VGE3b7MVSYDgazxppzQbuwyeaS?=
 =?us-ascii?Q?15pp3mI3Zed51G7giUG1aFSDiojKc5tUreTDtrkW8PIQ+cbWJnICLmcVMEHY?=
 =?us-ascii?Q?Bi2qJV0Oblt1A+dkOEa0CpZH/p6AKnGvWDoqnexC4QR8YMgSEzhHOTVQRR85?=
 =?us-ascii?Q?ojmGiE8yuprbRHlzp0lj29fJCKqWtEftmV8TG5O5jDOAdvnZ8fY2yQvLqheG?=
 =?us-ascii?Q?GqYRW9Hd7FqcYynL16SiusNCaNlUoLbGYSY1RVEIPixXfsrASY1DlGDtqQzr?=
 =?us-ascii?Q?MqkUpuI6w5dTDOyiHGBLRSqh2638bbx5OqnTSOrm8KHyI6Z1WdFQsGXplOLN?=
 =?us-ascii?Q?p8KYWHuJl/hhO23L6cKOFgKE6D5lRn0wZvcsPFamGu9fVmV6yfv+xCokBuHB?=
 =?us-ascii?Q?qu0txkHTDyNERDJnsHdBgqKFTmO71fwcMHVMDti1rjasTpAPliM+vgn7Yk5y?=
 =?us-ascii?Q?FWWgEh4aJQfxuRatIlJPZxOZ3ObrVu0ubJojMcDI0oUZBNjDt0V18poHNgz1?=
 =?us-ascii?Q?gziaDBZn91YE4A24UoT3CJfbbpeTqKjdqwTb+bzSD3Hw5dNxxnfFt/QWRpN7?=
 =?us-ascii?Q?xluudgP/r07aiA2+2BXjCJbCQJBgggR/jGKkbF2eEJXHjqWtLOTJZvz/GcCO?=
 =?us-ascii?Q?yZ50KoXeyDddbQdqeACiA9lwuc69XwaHOLJHUXfHNJTyFHc1sLfn6VZKaqZ3?=
 =?us-ascii?Q?tS1baV4qb3So3qoz7lgxsyhJiMc+UKly7ACo9D+VST15GHoRdbmKjdyJOH8F?=
 =?us-ascii?Q?6775AkdzzXjESzbtboUVv7dtfaMhaC4dZY5dDMVQvVgBQkNCkG63A8LKTnML?=
 =?us-ascii?Q?XNRqFW4FE6bxocj0yg5xx9M48HEzPF6OhKmdvWr0K/PWlORwIWeodg+E7meP?=
 =?us-ascii?Q?SZsXp7SRevdWbXtFNHo6BHkeavS7ATWIAQjpUdBEl677EDqOfu6yQ2L+kGSj?=
 =?us-ascii?Q?8F18hRSsBLVUgV8lMx9z21w7UFiRP6Qwx4lOC6ICC+E+yFkCynztqsmHbIRA?=
 =?us-ascii?Q?HRQGbBizF9eAVX0o1rK/Tkh4mOnk/pSBIVkbN3nsboetK8cLRReHAl/iCo8Y?=
 =?us-ascii?Q?N0Lppl7EnjFkgz8cIhDgCNixTNo4lqEwjHmLYvstan12N3Z5edsQecDsBHRD?=
 =?us-ascii?Q?lENsjIJFwiCNueEvb1eaVXYnCOO6f8vNpmYqnhZ3haoTSmbQRSmRJZKCJb4X?=
 =?us-ascii?Q?XZQCR+6YBLAjje4J8ML49ewy9eAAouBeTkoepMrq/Ej9KeNPgxDXQEeF8oj3?=
 =?us-ascii?Q?GhCS76qUnoX5+8o/jVWdzmjVPFLMZvpeGiZNSU/fuQRuALWZZlkzkD4Wv4a7?=
 =?us-ascii?Q?B1DpY8jf2oYQlZFyrX34+Ea9juZ9o7HBbxv0wIoHyJ1onCXB9Z1blPfu1WKX?=
 =?us-ascii?Q?LKv4se8CCjpdFbZYbAe0wMPZfvuRftWo59F+qwSFGGuhUGVkVdhHxOb06Ql1?=
 =?us-ascii?Q?NbMywCcZmE/OzSwX1mvNklq+sz3COqMmsjTeHXVwKGfF+BpDJtkAcQfaSObW?=
 =?us-ascii?Q?a2bYJ+29DFg9rWzXKDWnUkQriHpIHbiiGpSvr6KJZVpcmCwR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8841640-80b8-4d54-647d-08de9b0e84fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 16:46:19.5930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAoj53QKiUBKw7aawh4reqTHYbsnUhuiR9evklVD9pMPQHH9UC8mNxAC8j87Rx9j45rRNUKFo7eEsA43FW+47Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB4775
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10184-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,outlook.com,kernel.org,google.com,vger.kernel.org,canonical.com,templeofstupid.com];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6921.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 6A0634067D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Dexuan Cui <DECUI@microsoft.com>
> Sent: Wednesday, April 15, 2026 8:31 AM
>  ...
> 4) For Gen1 VMs, the framebuffer always starts at the fixed
>    location 4G-128MB.
>=20
>    4.1) By default, the low mmio range also starts at 4G-128MB,
>         and the size is 127.75 MB, i.e. if
>         hdev->channel->offermsg.offer.mmio_megabytes needs 128MB,
>         the guest hyperv_drm driver can't find enough available
>         mmio in the low mmio range, and has to use the high mmio
>         range.
>=20
>    4.2) With "Set-VM -LowMemoryMappedIoSpace 1GB", the
>         low_mmio_base is 3GB, the low_mmio_size=3D1023.75 MB. The
>         fb_mmio_base is still 4G-128MB, i.e. if hyperv_drm needs
>         128 MB of mmio, it still has to use the high mmio range.

Well, this is inaccurate: in this case we could reserve 128MB low
mmio for hyperv_drm, but this is not really what we want: our
purpose is that we reserve the "initial" framebuffer mmio range so that
hyperv_drm in the first kernel doesn't have to relocate the framebuffer
mmio range. Even if we reserve 128MB low mmio for hyperv_drm
starting at 1GB:

a) hyperv_drm can be blacklisted by the users so from the host perspective,
it's still the "initial" framebuffer mmio range that takes affect, and we s=
till
can have the mmio conflict in the kdump kernel.

b) hyperv_drm can load after hv_pci, so we can even have the mmio
conflict in the first kernel.

> On an ARM64 lab host, I also tested Gen2 VMs (there is no Gen1 VM
> for ARM VMs):
>=20
> By default:
>   low_mmio_base =3D 4GB - 512MB, i.e. 0xe0000000
>   low_mmio_size =3D 512MB
>   fb_mmio_base =3D low_mmio_base
>   The default framebuffer size is 3MB
>   (i.e. screen.lfb_size =3D 3MB) but hyperv_drm:
>   mmio_megabytes =3D 8 MB, which supports up to 1920 * 1080.
>=20
> With the below commands:
>    Set-VM -LowMemoryMappedIoSpace 512MB \
>           -VMName decui-u2204-gen2-fb
>    // the command only accepts a value between 512MB and 3.5GB.
>    Set-VMVideo -VMName decui-u2204-gen2-fb \
>                -HorizontalResolution 4834 \
>                -VerticalResolution 3622 \
>                -ResolutionType Single
> I thought we would have:
>     max_fb_size =3D round_up_to_2MB(4834*3622*4) =3D 68 MB
>     excess_fb_size =3D 4MB
>     low_mmio_base =3D 4GB - 512MB - 4MB * 2
>                   =3D 4GB - 520MB
>     fb_mmio_base =3D low_mmio_base
>     low_mmio_size =3D 4GB - low_mmio_base =3D 520MB
>=20
>     Since 4GB - target_low_mmio_size =3D 4GB - 512MB, which is
>     smaller than low_mmio_base, so low_mmio_base and

Sorry for the typo: here the "smaller" should be "bigger".

>     fb_mmio_base would be both set to 4GB - 520MB, and
>     low_mmio_size would be 520MB.
>=20
>     However, the actual result is:
>     max_fb_size is indeed 68MB.
>     but fb_mmio_base =3D low_mmio_base =3D 4GB - 512MB, and
>     low_mmio_size =3D 512MB, i.e. the 'excess_fb_size' is not
>     considered on ARM64!

I think this makes senses since " low_mmio_size =3D 512MB" is
already bigger enough for the framebuffer.

>     In this case, we'd like to reserve
>     min(low_mmio_size/2, 128MB) =3D 128MB for the framebuffer
>     mmio, since the max possible framebuffer so far is 128MB.
>=20
=20
Thanks,
Dexuan

