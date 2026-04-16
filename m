Return-Path: <linux-hyperv+bounces-10193-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF2fMkwv4WkdqQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10193-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 20:49:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A1413DD5
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 20:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B9E8304241E
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 18:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28217340280;
	Thu, 16 Apr 2026 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WW8nhs7D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023131.outbound.protection.outlook.com [40.107.201.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB5334C3D;
	Thu, 16 Apr 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365381; cv=fail; b=NsQQJTDkBIs+2r3b9C6btxXzz1q3Xei8zngPMlQ/hab7WfPCpHgat4H8YkQAZRbv20OXzhHPJaRjKypzqumKsGLh3f7Y4VzKRVnVFu1tonQY8rPweOFCJgLIkdKYT2Ru/nm80S1CthLPJoeqCvojZXseM/qpdAN6mLFxEp4EjY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365381; c=relaxed/simple;
	bh=s0haecRgbsnxbZp4YD+bBWUfyc+rHX2LNsAGU/dRlfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bh+0cSUjEPyyv/wY2kb6LMul8oU1ugltFf1rlip65bPam+TLbo8R+ZbcEQpwtP6w7i5RbYipu4AQmdS5Y0pwqImZlExP9dIjNnf07kGzU6wYXEevFFAzZ6PCSaSVOSMUGtlmxJY+HcztSOKkUAo5Yo/gbpNMQL6v7HJp4w2f7b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WW8nhs7D; arc=fail smtp.client-ip=40.107.201.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2FF0B7A9CvwJ8MDE+23kPjg2jgrk2MDQn66gAEobQrfX6Zaw2JKsF84+dlj5Rrq9bFwmim4dyfUu23/iyXcq1T94tQsbtd160cwDveB9Hg4Lt0JCyirP4lNrj19F/gaP9nN2BKLN1xfDrgbzKXUpgJY2KFXS+NCzMy/6hS+9oUVYVRmVP10SvqnE5rknJpOR5we0AQrqkAvXhEhINidVsomxg0+ep6qXCa1Ic79HOeeHOaYJvhIuySeb+GDJDw/fPsuYUIRE/XwlEGu2br1XlkhEg9hrvMwaCASQVWeQ7QZkDP3Y0aC+6Om5bPDcCdAlMnTGhyh/74JK4l1dBc6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0haecRgbsnxbZp4YD+bBWUfyc+rHX2LNsAGU/dRlfs=;
 b=ChMEQk9u4LK/exDtlNwwYlzZaNj0pkr72d6qpUNr9OYo9eQGU9PL0J0Eif4bRkpoY0G4LMONdmlUO4MaHYGD3RTNSDERUaKxz+iofK/eUfqw3gUrA9xCyRPMSasGbPX+xd7eEHXYBPpvUrDHRZyrHqY2gBHO5ESbO0Fe4wGhje2+LAEIjsLuAv7pA82kI+R1HB5hSYQ75Z6XawKOoJJ/FRv7fFwgVP+P3eO2PYu4mI7Oo68R1FyBjTOijF9B48jU4WbLQgPLVCaocwuwpcDKeShgurTozo2Y4a+6YEYnJe+43sxKrqhpGKSzKcRx/i+hT5+bSOWRj+YvcPtAXm/fxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0haecRgbsnxbZp4YD+bBWUfyc+rHX2LNsAGU/dRlfs=;
 b=WW8nhs7D0pKGiDFf+cpCOg07ZYynG1xGaBf3Qu8w/E22fuCwpDZTXzZo4MVsHg9JqX0P3mm835ad72l7Pci8FB6fnWxVzqDHD5d5zfbXJ6Dx7GtGsipd8CNKKaI5GDaPnKzJBfPeJsbDBxeDvlaggCdPYWWyigmzFjWWC9+WMlc=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6321.namprd21.prod.outlook.com (2603:10b6:806:4b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 18:49:34 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 18:49:34 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Jake Oshins
	<jakeo@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "matthew.ruffell@canonical.com"
	<matthew.ruffell@canonical.com>, "kjlx@templeofstupid.com"
	<kjlx@templeofstupid.com>
CC: Krister Johansen <johansen@templeofstupid.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHcwvqZ7/kLR2JkdUmudlv9HY41bLXRHh0QgAOgeDCADVwxcA==
Date: Thu, 16 Apr 2026 18:49:34 +0000
Message-ID:
 <SA1PR21MB692195828E5BF1698232774CBF232@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260402234313.2490779-1-decui@microsoft.com>
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8081b72c-a943-4099-8407-b0c722844253;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-08T06:38:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6321:EE_
x-ms-office365-filtering-correlation-id: 5bf9d4c1-4935-44f4-a739-08de9be8e727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 s9cotUakO/eQG+hqkFVPvsCRLgdtxmWhUHJXjhicNkfhibPuYG7dNiKyB8RIGFI/XZL7fKNAvjsi6mLoHZGq5G3+rS34ZgrRDVvrvXE2UDwiIhnJF1Eh8+Ji4gX8N1aKWvW21m5rxjY0N037YPiZ8A738l62f6I04QtR4iH4tFD+cfAp6WPVtRbnlQrt0sLE045TvsViKk3yb1qhZjwXcxoZDgkFnh9M/gLzcIzB0anlJmWxlS0XS/8ZWMpJPaObHBMUfq93mMRNIts0lS0oBdaKqJ7nMbohn6GZCcKRQuwibRg0dCyUjAkwn/jy9IobrHne+MPfN44KCJWlYQdrUG9PgcrYcYnjOx6uNJhS3Hd1Cc3JdwVj1oGyYWP2HA0sh9gry136jWNDKczx5OAL9RNxmFxQfgAfuGuqLwkkuw3bXU02ToZ9ljS0HlZWZYTm6BBaMciT1+kEGM4KSJW3ZJSmsawNHCxv5sVwXYeE6CWb4h5U84p1Dy74y9fzxtjpKU+PywbBngcxIDHkQKk66iXBwyUc86WfmTr9bMBtCuTSOgUfclXuwhPW1smL2+FGyv6E+X9xFhgqRSMmR1kCWm7kw6M+zOUHQe1UuegPZaHxuk0za29VnmR68DbmDl0H3N7MzqJ7KPHEpz6pFLDV8U9Zz+wxgVLe4MhFQVuM1vJFoKKR9qRJ01YaKQtZUkGb1v+blIYHRrsM5POTlp55CLCpbHVjUX8XQQ8M/jz7PBD6rBOk9VOUJou7VZhMTbHsXDuS3JtTDUP6J5wInIjLFA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jzuFT0siUjWrcdgX9Bd2rvJm+MgMCJwKj7DU702tATV1KEbaP7++ujACh6pQ?=
 =?us-ascii?Q?S4Dyt028Oz9v/vXavXR35ZyCHUGT1uugAJHCBgsBw829BQoHoTZsyE5KVfKT?=
 =?us-ascii?Q?OPlYV3PM4zAbTe2GTuIsZgIMoPWBOY18vPDaPm51rCSwih/2sm5ha/q2Wiy2?=
 =?us-ascii?Q?cz8CwqzEqtJZ9sJseysJZNLa2GjaFVqIBS5BAvx7tOqPM45QVFy/h9hXDGC5?=
 =?us-ascii?Q?SpyAeUc2DA/AlMm0MpW7I3rcff4nNDT5maPFlxjT884memq1AYLmlz2TSI/O?=
 =?us-ascii?Q?oJlQbRqPmP+/pck6oDj3UWrNzu8iN5bTyho0JDNwO7J2jEamBqZY+umWMkhq?=
 =?us-ascii?Q?M0isCeOQCEFprai+Wx2BGG/BWENbUQ/v9LhEAMEHij4inknQqHgpSTds5g1Q?=
 =?us-ascii?Q?FfExFQxloww7Mh9tKXeKVFMT1VMLx5+NBdGSR47a2ahN68BW4KWF4rWzEKGL?=
 =?us-ascii?Q?wYSFaU0pE2abbVF9fAXrKW/RP6lb6C8juo8CmB9yIhAmzGBIhuNXyOBWrtnr?=
 =?us-ascii?Q?CxFe32ks62NHbxM86SYfINh/tJ0ZgmFIKR/QQlPyMg9hTqnZN6Z6LUTlHgKp?=
 =?us-ascii?Q?IwHRq0UNNOOD7vHZrvU9qdN63hENZr4mfES2y51Jlvp9VJeR3fMlTgbs4Wye?=
 =?us-ascii?Q?IB9Jn3162T6JoPMny3Z1c1FxzA8lAQNIc9QvXXVUiKXDVhaKvXmAtES+Z5vc?=
 =?us-ascii?Q?Sbxu8tUghElmX1mwFFmy4DI26ZTILcT+6VmM7oO+TiO8HAI+BH2mDsPO3X1G?=
 =?us-ascii?Q?s5Dkar4WMv+TyH3TiiE58ibsp8HU7TsMyzemJcg21UdNEaL1IuYwNoxYMNSN?=
 =?us-ascii?Q?l9uHHVGkl3bNAY99FZK4IUqJQZhLSTCVZMaW0VleoAYs9CwOw8HEJG/f5QG5?=
 =?us-ascii?Q?UTxcNrQHhe5QLlNT2d1omZVZHjh2CvTj/CU1qB7zjgMaovtW8+l4T4EVAC4T?=
 =?us-ascii?Q?GsEFmXeBbhhB4MBJVeamMM1f475waLwU+Dzp0ngsrAJ+UXqK/n2KVLegvm62?=
 =?us-ascii?Q?kype1fh5XV14PAof3bzR8IbVq5rfyb+SS33Sd9PfSDm8KiLOwBWQFH032A2N?=
 =?us-ascii?Q?knqLH8CZnmNzazPZbS1d5F84qiwtWsiLzrcddiQNJJJXSQ8KwVYoU8xkIgsi?=
 =?us-ascii?Q?ezLaUe2Mfj6ISpmdWvXUKFQ9zh2hDo/YUUA5pMW+ofFSMolzvR9FSIbg+ty+?=
 =?us-ascii?Q?tfgMzU2YTgnu7WiaMDj5clZ177YcFuA3rOUOsLx7mWnsL9NakD7qIiOZm+kE?=
 =?us-ascii?Q?7Yr+Y8w4VyVsMCgLxqMOOsTBk5cpSoOFIQjomIdHJaEbm//ihA4iI8qA3ce3?=
 =?us-ascii?Q?MWy05fpk1uuyy20tSxdEvWDMGOjFfg0nzS0XqZ+rbrCjsuhPbeibXnbzBpyh?=
 =?us-ascii?Q?252yorKaNXfSNhsyr1rmbU+Y4lclFMrIPIHu7iFA/rD0NeHKwhC+R8bnBPiO?=
 =?us-ascii?Q?0Y6d4zWTpB+1gIP4QGbPTj5znofp5iktK7OYiKe8OflnKCPyfkKwWa9Ia1Au?=
 =?us-ascii?Q?Q0HeiBWYbP1VPUUVeH2t+XO+8JYi9hpp9v1kGF+yBQfg0PavKz7f7bwajic8?=
 =?us-ascii?Q?NOMq+QMc8YHFbLOZFtHpydLKlej0pJIPj+p8qCdKq8EhPSK9JKTpWXbQmtmf?=
 =?us-ascii?Q?WQtKyzwePvmnxomVmJDACdTh7znBQmCkq0YIetebRU8UuWMXllzZz5VEFThL?=
 =?us-ascii?Q?piQQBHOOjjRF+knzufd1LYDu1CqqhhDmIybZpXDabcy01cQ1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf9d4c1-4935-44f4-a739-08de9be8e727
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 18:49:34.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kh/AtsLEJsOE9Y8x/5dOIhtdW4nOph7OeM8sJwvLj++Aw9/7a6WjQp0/9ml8OT4dJD0nItBzdeE7Ke2xzAqL6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6321
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10193-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,google.com,vger.kernel.org,canonical.com,templeofstupid.com];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6921.namprd21.prod.outlook.com:mid,lwn.net:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B8A1413DD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > ...
> > This approach could be taken one step further, where vmbus_reserve_fb()
> > *always* reserves 64 MiB starting at the low end of low MMIO space,
> > regardless of the value of "start". The messy code for getting "start"
> > could be dropped entirely, and the dependency on CONFIG_SYSFB goes
> > away. Or maybe still get the value of "start" and "size", and if non-ze=
ro
> > just do a sanity check that they are within the fixed 64 MiB reserved a=
rea.

My earlier reply yesterday explains why we shouldn't get rid of the
screen.lfb_base. I'm trying to make as few assumptions as possible.

> > Thoughts? To me tweaking vmbus_reserve_fb() is a more
> > straightforward and explicit way to do the reserving, vs. modifying
> > the requested range in the Hyper-V PCI driver.
>=20
> Agreed. Let me try to make a new patch for review.

I just posted a patch here:
https://lwn.net/ml/linux-kernel/20260416183529.838321-1-decui%40microsoft.c=
om/
Please review.

The new patch changes the vmbus driver. With it, the previous v2 pci-hyperv=
 patch
 is unnecessary now.

Thanks,
-- Dexuan

