Return-Path: <linux-hyperv+bounces-1915-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A2989777C
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 19:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08D928AADA
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE0D15351B;
	Wed,  3 Apr 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AZmW1RPv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11020003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072EB29427;
	Wed,  3 Apr 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166868; cv=fail; b=AZXE1TpXfnW+s7Abnr+NDtyb6T5GwL6Rf1hJMBtVpnJPpQDvPiLeCO3VXk1wppU+kupE5cohFtxG35UK9cCu4yQfBffaICzprgTtYVFYJ0hkKfDfSjxea+A3iKY2Csxjql+GFZ9gJI4TAgB/rpsX3IkujnLrHaGmM9Y5KVCBDTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166868; c=relaxed/simple;
	bh=ptCxJV72xIhgefXqDquFTZU6fZYQNKyEvQxCBnWdVoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0M+2QaNVTmQi3TJptaO4VSPJRSCwTfAnIWrR/zdlI+GY1B5grVvIuUbhbOASOuesRJZ6l3+EZP5dS2q1kv1lV4UZGqm8LxiLlsCywZIhXaFLg/UCcUbmvtT0vqUKoxCCaZhLY9cXRZXpFxMn1t2+hP+kvBNax+WhZ1UiYc9cg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=AZmW1RPv; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDLK3BAUkw+dBsJYg6/4PmDfH09nyk8xm89YlbWSeZ1gYokPZTCF3pSDK5TrT9ePoQNYgoOBPypflZB9ubzWc47bWBifE7J+55ZfsjTDj+9v6Q6cMBnDfNdozC1Mep0zIIxBhPF3Qq/UZ2yLjSfMSysnovrYYrMnWStma8ZWsBeJRB48PtpR7gDWhEyyVzDLgAQf3XNdfauQBt9juWgx4GU0qw0KSRVfRsbh6nuqf5jhrO7sgc3vp+/4jwUUBklMHIVPoTEECKB3ZC0WqOGmMi47Xp09Oj9T1E9WloTFQOqinjqC08+B8RpN94o6lTyMtDwfGLd9aRwn8KQGlLXtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptCxJV72xIhgefXqDquFTZU6fZYQNKyEvQxCBnWdVoU=;
 b=R0Ll2l0uUgQ4z8nezO8x+7ERDeO1nzMn63m0AoZj55s2DTqVYOi30BNscK7a2WzKp/VsqpDIPgZLn/izF05KE73PXDLb/ZJtTDNI1grheiWUOaYfVgbAR9LcE2o9e85+nGwo46/wIq09RI03aC29xBAJlta/CyL4IVBsev6lO5Eo4ggv9bBQmS1NAsM4fbHPIj7i7myavowMJyCjHYl3oovzHEPcLme2EBYL1ZyVethdH0fptFqdGNnd5MUiwWTHcVEEVn856rtvIq5/FV+eBRYmST6AukF9vx/Ln8l+DhPKE5d8Q77eiotUvfF2HY0H7CQuxddV2XPOCvh7rULAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptCxJV72xIhgefXqDquFTZU6fZYQNKyEvQxCBnWdVoU=;
 b=AZmW1RPvkNizeHPn17SVp9qu6a8NHDBHrjopa2WZUqznOjfN8ZmcFj2y25c6ZwzjtXwysrzJuyql59XGOvagHM0pueJMX2E4W+DvxXvOvDd7ZF0sV1goYCZZd1Hqi/ncZY0nwKVCZnwInepKnv3V14YPDCT4txxQ5KGUwWSvoNU=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by DM6PR21MB1435.namprd21.prod.outlook.com (2603:10b6:5:255::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Wed, 3 Apr
 2024 17:54:23 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7472.007; Wed, 3 Apr 2024
 17:54:23 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH v3 5/7] tools: hv: Add new fcopy application based on uio
 driver
Thread-Topic: [PATCH v3 5/7] tools: hv: Add new fcopy application based on uio
 driver
Thread-Index: AQHagn+OVH8R7Tk+8ky7xNS67Tqs/7FW2rmw
Date: Wed, 3 Apr 2024 17:54:23 +0000
Message-ID:
 <SJ1PR21MB3457C5160EDF33F7F8472972CE3D2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1711788723-8593-1-git-send-email-ssengar@linux.microsoft.com>
 <1711788723-8593-6-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1711788723-8593-6-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=654f541a-7243-4cb5-a8f5-fe09597ea3aa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-03T17:53:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|DM6PR21MB1435:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xBYwhSP3ikzRapPmAtwT/6G1zdtbki5Z083C3Jvw1whUhCmg1GNnxvvDDX3C6gp/l1EDnaSD+rp94SVMaB2tMNiAIOObRKKbY5L54Di1py72qLXW+3zgJ6yS44ZulrrzWbl8NVgTuFlcxJfDzZHoCcBQCgjS2FwB4G8jp0zdepHSftn7J/1ew/vyJFNgQNsk1TNoiiAJe7eDZoc1FuHxJswO5fCybAd57uSqu1841+5jvw0vvb+z1MnIkIw11Gpd9bpc4IgapJpL4ZG97uvzpImQ6IUJEZ22tpSKjfm8vNL3esRtRtioIM29SxAQWwdVeR0rEXKJuiOVFYfG17WvogTnwumjU9zjTTvQoJF0yYndSQw6N2TsGBP2FU2HVcOl3kkE8Z7lGfJ3hDrnLYsHEpd8zqTPN/kMlgZ5MO6GJBIjEfbn9gLsEYzx1Oz9oe5mAZEP5qHydmgnwTAUt3U+NL+vF0zyY+F0JaiB54IGtoT8p8uCrqLM8t4AS0LUcwfx+3w+xR3Sm7IhjkpD6bTP6PfqpOB9QNvaSJDWXnvIGS8jTKuiHbI5Q5zhmMmHIf9V73NkN+JwltD8mtzbHwiL1iBK0q2AwauVptMg1LEK3vAc1KHResC9/nbk99ukWwixzn8AuBQ+aQdHTL7wDDaNiclE/CQuwoScnGXzFf96qfM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2G5gdf6pIWZXQrVIKR6/1ebH1d95WNffUd8xcPgYboa0XfBsZqfMZ6AHRaBq?=
 =?us-ascii?Q?N/pcYF9wJbxILUbOA3/giMqQJsG7zko2uS8pLflZCskI97dfSGwdGWLnVtGl?=
 =?us-ascii?Q?CMxrOcc5bt2SW5E7UnA1jCIj1hPzVUpszufNFnO/GnyPczdNa2CIwxTm/CHt?=
 =?us-ascii?Q?RwRL9mvFbsQ/LjOyLIXDP9Mf+F2ZhxmCr2fDZ0UqA6qfKG2qYUYajiRqV0c+?=
 =?us-ascii?Q?QoNuQpnCWD4+sQO73ovVX5sysir5gh5DfWNAnhEnupwMouhL0oQXyZWqRLSU?=
 =?us-ascii?Q?8H7Ea8SPipL/OB56+mrKAXIt5FM3XUqNfYvDNnH5dIUskzwf9q3KP/k6JxNT?=
 =?us-ascii?Q?PYxagi7IhCjFKrCdXT2XiuxIPAwSMQ1JVcWuJgOO/hzwh+7Ekz9cKS3v3N2i?=
 =?us-ascii?Q?jnBcZNfyPVZ4GLaPSHe2MVNgTAJv39f+ESXlujh2VqMBO4HUh+OQx0S7MB8S?=
 =?us-ascii?Q?RYG6FH3nCagefePX06x2/UocDNFKGjZU86GS6isJjGVDZI4aPOAVxJS837ao?=
 =?us-ascii?Q?eBY24Ya18f2zzo4W4onIPu/ACbOrEjMR/IparNwpSI+I/qEs/Jib0KFy/lKP?=
 =?us-ascii?Q?NCwGmywpjd6CNZ7HaaBlBVDNBivz41/4xUcURkYmB3XYckx+OQPl19oQFE9d?=
 =?us-ascii?Q?/G7gL/oqkGo4PNcXtqyKJrdhanG6M9PlfpNocN44jly/9YDgbaHQKPOYeqJK?=
 =?us-ascii?Q?uFRC1cjEgw06jVWP9JOq4shCMw0y1qGkXVHsy6xo9U2zPvqMPQzA9wkqHTdI?=
 =?us-ascii?Q?GVTu5PuSk1AcDn7pTR7AgvO3S84DpVCLCznOGyyvYGRgHHyOHrxCkRvapaAH?=
 =?us-ascii?Q?f/2v9o7OwPTuq5W/BS3mA/FbUiYek9d8VWmT6uwfPyUeswNJUWrzvqyBQxDy?=
 =?us-ascii?Q?C2Ee2Biu6Mrxs6uNK3tNyxUP15Gl6HvMwT6V5y+JA300cAPGH9M0YTwVA83v?=
 =?us-ascii?Q?wQBNNTdAIzRWIWfbH7mxZLsPIVCkaWHNVtNnuOxMP85ykGlh1AuHKQUACPtI?=
 =?us-ascii?Q?FP44A/evbTCjXzCcIMv2DPSkybvlTw1C3zKF8YmKDqBHEihy0H1qFIlAnmHC?=
 =?us-ascii?Q?SOw2hu2aXgpMaUN19a+a2pV0p5vGOzSgKBZ8mSaRIaDkkT7NLwRVH9MXiVUZ?=
 =?us-ascii?Q?iYByjdGWAkAY/GBZwjopHM1fr/rNGfFvUCGK9q8npmjp1SrVorq0stKdZUns?=
 =?us-ascii?Q?X/HPiFEM9O9PywTbZi5PsmIUl5PRLv1z1hsPU5v04ownjHg7uQw56sK2Vsz3?=
 =?us-ascii?Q?OdXE6b0MJPsQx5eNDAfLYkM7zyJOEYtOpNessu4BCsxNiDPcagvrvUU3pgIC?=
 =?us-ascii?Q?KqzkBLReAHFXuVGLh6lStjnhxAZWvEig8iMG1VmS7/oYqe0nTSenVO7e6IDX?=
 =?us-ascii?Q?Xm2axN1PE+XaDsj0aGwFchDKkltW2Zxarfeqf5sTvzz6qbxznRujPcNJ1a5d?=
 =?us-ascii?Q?TOuTXHeuL2hLJznQrtQzHmdG8t1oU1dnw9BFE6b+G30G/TnAsXPWKVawucUo?=
 =?us-ascii?Q?dVe5JPSPQvEqWfNXqRvPYgzjZzU78uxKtFxw/J2GzcPqL8BGOt4WMwnKVIRg?=
 =?us-ascii?Q?qHRKme/+stLNMgVuHZAwDoF9ofRv8zkVQWWJYLUb?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb517910-4151-46e9-c708-08dc54071884
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 17:54:23.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAVTLfAoFMXgMhNGSlgb3e7VswBeotJxJpXYFQEXdKO/4LHTwocacnrPMse8/BzUg/DBT6wJ0G6CklGShg/IZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1435

> Subject: [PATCH v3 5/7] tools: hv: Add new fcopy application based on uio=
 driver
>=20
> New fcopy application using uio_hv_generic driver. This application copie=
s file
> from Hyper-V host to guest VM.
>=20
> A big part of this code is copied from tools/hv/hv_fcopy_daemon.c which t=
his new
> application is replacing.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> [V3]
> - Restricted Makefile to x86.
>=20
> [V2]
> - Improve commit message.
> - Change (4 * 4096) to 0x4000 for ring buffer size
> - Removed some unnecessary type casting.
> - Mentioned in file copy right header that this code is copied.
> - Changed the print from "Registration failed" to "Signal to host failed"=
.
> - Fixed mask for rx buffer interrupt to 0 before waiting for interrupt.


