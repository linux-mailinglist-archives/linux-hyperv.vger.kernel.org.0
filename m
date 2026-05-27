Return-Path: <linux-hyperv+bounces-11253-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UERkIKhNF2r7AAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11253-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:01:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D95E9DB7
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 22:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B874530A9335
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD063783C1;
	Wed, 27 May 2026 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LuetwK4b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022124.outbound.protection.outlook.com [40.107.209.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A537472D;
	Wed, 27 May 2026 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911688; cv=fail; b=PJFn7M0S15vEQ4Bzn1SaAdSi9KD6KbVrl42uSNzp9sEDnZbw3tNGbDr9d1ApPhFUK/fGMATgqGBcCHaG+M7JD79u1BcFJyBR0Qpyin0GeBDLtnBUgq7WnThsKaAfdokftfsueg1IlY7BMnrEt9LvlskP5XRzkl1aTy0HN5XvkGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911688; c=relaxed/simple;
	bh=cKRQP/AH1KHxquxZnMU3gbp293xgUwGpHTUjRIkKfHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pLR6dE3anVMsseEIQ9W/WKXurovG/FK/MXN9a34ddpiwJ8knGKihTe/eZlIpVtDElqQGJplCrK0ixle3tPezXJzL2TgGdclN4afGe5VKlekEe4RqYjQlvIzwag8Mg7tDgEOhJShwLWLk1lWRAOnVqwI7S8PD4WOzvw1KtgxtCl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LuetwK4b; arc=fail smtp.client-ip=40.107.209.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um+qynobX6nL7PBKn+HoMnMm0SkOmwnaowUrDDULkuZrdTTJuNDj7+4QbD+U0Xh7DHOZ7J5jcB2/WBofmctIParZx8gFidYY162MWdokaWg05ncMmxZfW1qgmv0tI6MiLFceJc04CsCVZnP9VeoRPhbk50CQAml5lQHPeN5DmRLXIiaje+60cdIi3pFdg0ACPB1W0/khArZTkZQHjZZb+65TUAx/CAr2Z3xh0idG66lWFW+LlK8CZjUdi/6Xp7srzegVjHA5SsXOlKzGhFinMy/JUIAq1VXpkb5yPddQGNvqiO6qTrelcB5xzHQxjtjYoqquNo0i6+qoccG/iArwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Vt2Z2hals0DEy89YCGfRUjS8AwNH6iyjPxXpzN8FmM=;
 b=eyHwVZEX8jvUPKRbRmqfYYEQ+aVUvDo+eun2yZIkumPOrbvRDvNmeNoCazociLjgSYV/Sacl4HIRkyF+Ljno4ypXZtItmLjSWzEv3Wcym5fUVfMLnACSBsVYqHQCu3hMsx8oQ9BCJ08d9K1tkmKDc3e0HuiyE1BiAiJ4HRLy67MMlJBUCDNRnEClUwXE4rnXAN5X5GgreWy8EPZa+JrUdZOCDGss0kgpf+oOvy56A5MEufn43Joz72lDUX4g6Xtn9SPYKg1RaNwVAQB305XblVKB+Ohtk4qagEI1Cnq9vrOGXt7a1bO+VGOBf/sIjHxPaEiXn98CDDX0EBrn4alDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vt2Z2hals0DEy89YCGfRUjS8AwNH6iyjPxXpzN8FmM=;
 b=LuetwK4b6g5G/+rl22y52cYpXR0R2iZdiN3I7SlhSc+AvPcPExylEkqLIn1whG5lBxcGMclD9rs7YX4D+PPc9hOYRf4T3CVITxkBAZj5XMiaThR5HW+7agF13O8TZyGsNJbfKDCyNsjZayyFicsf8Rna9VbjpW8qEZ6Sic6YaNk=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6658.namprd21.prod.outlook.com (2603:10b6:806:4a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.3; Wed, 27 May 2026
 19:54:43 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::648e:8c2b:b5e4:aefc]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::648e:8c2b:b5e4:aefc%5]) with mapi id 15.21.0092.000; Wed, 27 May 2026
 19:54:43 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Hamza Mahfooz
	<hamzamahfooz@linux.microsoft.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] drm/hyperv: Replace "hyperv_" with "hvdrm_" as symbol
 name prefix
Thread-Topic: [PATCH 1/1] drm/hyperv: Replace "hyperv_" with "hvdrm_" as
 symbol name prefix
Thread-Index: AQGYZGmpZbciqp3jXtRxdrQwqzIko7aq6eCAgAAhusCAAEsHcA==
Date: Wed, 27 May 2026 19:54:41 +0000
Message-ID:
 <SA1PR21MB6921A2C91F67C10F272E9430BF082@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260526205239.1509-1-mhklkml@zohomail.com>
 <ahbr3aepFUuJ45Zg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157EC6C4CE3BBE2ACC3E86AD4082@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157EC6C4CE3BBE2ACC3E86AD4082@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3bc8e209-d16b-4be7-a634-eaaf4255031b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-27T19:33:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6658:EE_
x-ms-office365-filtering-correlation-id: 582f95f1-14e3-4c07-80da-08debc29caff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|6133799003|38070700021|4143699003|11063799006|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 8+i4faQdi4neLCl/nuAjL0/8HMiZBKt8zjHIlp23InQKliABrnIhwz82bK0atvZL0zJFNJDK2DZmwbbDkN/L146SYNyrxj/dKk8Xc2r7iVaUrSZ511bWQe39PmeyUds7LGRNQkZYPYFfkhIuzC66anPnHj4lgFRMgNC6r953KeONzwLO7jBkzxLU+FABf/s//0pqvz02xe+71DSqD+m26YXXuo27Etar3cXn+Sg+aTMEeHipCBVupZ1XlAiVVP4wrxszNYGlRI9N4PXed3kiFgqtf2zMZbS4xD4dLuqJgqeWptrBWCwHm3OxwkMqsIViiOvzhp82e7dtbKv/NyMUStFZMRztcn2aOmZaGVniQvDilAIs8exrnSTaa2tvzTpkgxbe1JDtjQDEbszvvX/prptX4jj6Jz1FJZwADXg+MbTgCjTJ8Thjcv1HCUn6rto22inLmQ7gg6jGo6ZB6PfBztSJnA1OQ70Djoizx0pH6h8AhtLI/vxbPftOX3BETlOTbzELuCqwgh2nE9RmxfxVt8dTAO82aDwR5GBcaPtzAkwJ3jxE7OSP55X3vogdKebz6VcZj3dd4dSob39LXT7gYrToxfygKJgKwF2DEHmrj5rf7kbslSse+eod9yzRNeH1Pw8RStsLqsFrlBizpFydBMTouC4orP/1jlQZW/JqoROGau/QlnviedKZtGIZcbVtu3D5/Sy+ocDv3rSmq2+fDLLLR+YNZxlG9XOBrf0vwoYmyVe4rIUs0GzhrDawaD4M
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(6133799003)(38070700021)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4QUXToxks5QJ9Xn5UEIIlupbv6/LZb5Qu52FeTcRUK6UQ5TB46F48AXZC7pU?=
 =?us-ascii?Q?DmiExH61ZxQRePP4f9KYpTVbJk8/t/ofuiwS5mDq+GlEN2cCuUKmx3jn7IE3?=
 =?us-ascii?Q?3mn9O3O8s6LFlnfNL3t5PdR7GsHHx9zMxbV7xCHQdbEldXr28xjvy4tCvQ6t?=
 =?us-ascii?Q?tE/VPzlkIf2myC2oaLibzwtImJbwa0TE1zC6cYN5hqC/SE3D3RbnFmP4ITsU?=
 =?us-ascii?Q?f8QredOoC+t22HilMJMeRfChWjboUG0V1t5+3slX2lRYHLHY4c9nQ8IRVN5d?=
 =?us-ascii?Q?kqKfipm1FgR/wd+rjfj6vMiv/nAVwvi+I9NrHtKUz47/x+7q6/ZEoH507+gT?=
 =?us-ascii?Q?PkVCLjraySMGL2vd6zu1v5spF81rnXfr0dDY4euTHZfBZ3ChlQ5T3EyUgPrp?=
 =?us-ascii?Q?mKnHscaOB5eCAaoMX6fKZrLAfGfw1V43d8I6utBwGWv7aeRRrfDdmmKnDyA/?=
 =?us-ascii?Q?LynHw4YRAK6bPhD1BL/QrQECG687y20YtgMMtlvGj5GZVDsz9xzpOe/BkzN/?=
 =?us-ascii?Q?/JwauzlzAQ+s2ATLoAFMN/6QMK4HWfzNPtOm7Iqsw1zDBD6RQPB5X99Dm3U0?=
 =?us-ascii?Q?i0cQQy+wwWRdwxxdhqfiz3mBHBgh8L2kkHGYfS8Vp/FLsAr0BqcajeJ7bOIx?=
 =?us-ascii?Q?lyXHZxbGNEdHlnSGc4Y3xQpagzYHw5St5N9z8hgITMQAisSG0LNDLo7bHtGE?=
 =?us-ascii?Q?COhz4x+/EfUywB10fPBFfuWYBYP4A+O3lmsFwU1LqCoVKlEMOFce2uFJ9MML?=
 =?us-ascii?Q?qBkIOGRA/ignq/ggiDcPObNxddmeLs1ejllMz9cYm4AeeWidtFk2VdTKK+OW?=
 =?us-ascii?Q?PPOpi7d4qeyS0p9Xf9SwRH1kxNvs867eFfZMPAnuCNla2yI+N64nWB351Pbt?=
 =?us-ascii?Q?KCKOqf/EHQUI00fuIJOCLHvlIWKWXje61QuaBSlfHbpFkJTHJ9rpLuo78MmY?=
 =?us-ascii?Q?6m0YqYaVnlSXoA6rQ0GStGF100L9R9JBe2dO2Ta9OVrq0pLBLWa1KiQ/I3s4?=
 =?us-ascii?Q?vG4j7YiJnuUXpp2fk/ARdn/O9/soM5S/0BbWn26LXCPUDkzBE+zy6s4Ii7/V?=
 =?us-ascii?Q?a8IGZlMjXf3th9AvokbhadLX/7X3+P7OmO2DiicnrMKFXvkACPSNegJdDIiW?=
 =?us-ascii?Q?XPBi0V7gWmaEIN4JWZ4i6bA5/BcqSYXNjKIQ3DI9SawNpC3v8PUVyHPyIRWl?=
 =?us-ascii?Q?OdU0VkJorjmOA1XXnVcyk8BI2CRebNt4krfjZ1Icq0cyvny48Jev5UL+Ipug?=
 =?us-ascii?Q?EhBl9XA8t9w+HlfbIwCTFkwyyuvzMZ0FqUvLtBFmmu6eJlP22GrfAV6bnfo1?=
 =?us-ascii?Q?wxENSCDGz0m6zW6laBypd3ehL2gQ7VQpQUGsTq+CLJMyFAmvB4dcxuk95HPU?=
 =?us-ascii?Q?+PSr+nZK2nDc9vzVP+TFvlgL9u7o5VyQKRvEDbRAAtdzxzp7Sms9tA5BQ4Kg?=
 =?us-ascii?Q?uwIYvC8UzuzK9fRlaKJnmxPhvjFitTaYM7bm4cOP1IEgUm6iPSoHp7jnQyg1?=
 =?us-ascii?Q?f2ur/EDnTewvca58fkJ1KuTDzk0XlsXtsUGyVy9IVem5HPF0IUFapdbgqhp5?=
 =?us-ascii?Q?Ns19fLwtYMyCzlC3YTKeL7dVLo4AuB8vSHdOTa9we8v3Qfq6VDF5gCoFoePb?=
 =?us-ascii?Q?ikQ5+i17YKOiMwtGD6vKx1REyeYsNjDEsCgfEvv3qmdcr5cg8XU2X7VoJnn5?=
 =?us-ascii?Q?HA2rFKECY9cpp2WpG9tN/gWDIYY0RwKskdxFCXVvX1PEHppi8xzM9VCelOMW?=
 =?us-ascii?Q?SICQollpwA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 582f95f1-14e3-4c07-80da-08debc29caff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 19:54:41.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+Onx2OjsW5ja7oXbsgb/mYjCemAocVriK7a+utCzwHM/0gD8tnR9bmsl9GnGn39VSmGK1mWDoFj78ip1qP9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6658
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11253-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,linux.microsoft.com];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6921.namprd21.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Queue-Id: B61D95E9DB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Wednesday, May 27, 2026 8:05 AM
> > >
> > > Function and structure names in the Hyper-V DRM driver currently
> > > use "hyperv_" as the prefix. This conflicts with usage in core Hyper-=
V
> > > and VMBus code, and incorrectly implies that functions and structures
> > > in this driver apply generically to Hyper-V. A specific conflict aris=
es
> > > for "hyperv_init", which is an initcall for generic Hyper-V
> > > initialization on arm64. The conflict prevents the use of
> > > initcall_blacklist on the kernel boot line to skip loading this drive=
r.

I also hit the issue. Thanks for the fix!

> > > Fix this by substituting "hvdrm_" as the prefix for all functions and
> >
> > I would personally prefer "hv_drm_", since it seems clearer.
>=20
> My choice of "hvdrm" mimics the old Hyper-V FBdev driver, which
> uses "hvfb" as the prefix. However, looking through everything that
> starts with "hv" in /proc/kallsyms, I also see prefixes with the addition=
al
> underscore.  "hv_kbd_" in the Hyper-V keyboard driver is an example.
> The Hyper-V utils drivers have both forms -- I see "hv_vss_", "hv_ptp_",
> and "hv_kvp_", but also "hvt" (for Hyper-V Transport). So the historical
> practice is inconsistent.
>=20
> I'm OK going either way.  Does anyone else want to express a
> preference?

I also prefer "hv_drm_".=20

> > > -struct hyperv_drm_device {
> > > +struct hvdrm_drm_device {
> >
> > "hvdrm_drm_device" looks kinda redundant, perhaps
> > s/hyperv_drm_device/hv_drm_device would be more sensible.

s/hyperv_drm_device/hv_drm_dev/ seems better to me.

=20
> Yes, I'll make this change. And in looking through kallsyms, I
> see that the Hyper-V DRM driver has "hv_fops", which did not
> get changed in the mechanical substitution because it doesn't
> start with "hyperv_".  I'll change it to hv_drm_fops.
>=20
> Michael

Some comments need to be updated accordingly, e.g.
/* hvdrm_drm_modeset */
/* hvdrm_drm_proto */

This needs to be updated as well:
+static const struct drm_encoder_funcs hvdrm_drm_simple_encoder_funcs_clean=
up

Thanks,
Dexuan

