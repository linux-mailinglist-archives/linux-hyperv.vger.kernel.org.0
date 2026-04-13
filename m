Return-Path: <linux-hyperv+bounces-10123-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBAgKMx73GlFRwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10123-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 07:14:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 497603E76D0
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 07:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 276093005D16
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 05:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D3C381AE3;
	Mon, 13 Apr 2026 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bfcIsXdb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wenUuiP1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D31437DE9D;
	Mon, 13 Apr 2026 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776057262; cv=fail; b=OUCsTj1euxszIU028/3fnfKzEEi3ekNu0GlsfLUDFk52ODV1h4BnEzdiqQB0vc7YhLK3/p4LzyLy51GRTywGOinBfvZobh6axmyF2k28KuwHPUArsJWShQNlwZjX3M4SvVbBm/MURfjQZpVCYNjq6FoQoJkOR5Rv4neTCwx1kdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776057262; c=relaxed/simple;
	bh=02NhDW33akjzLAWNzx2XiFmDusqBSljIwD6yvuajEy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ONGRK3yqUsMhvUX4gWO+AiuF6xDsp7gPbRlKLJAT0kUkar8w1P+cg3wNceF5HtPCddm2eYEUOeMbVq/PkVHKXZF8ey1jOLNFmejI5hrkUs7Kzc2Bom+T0ahrDKBC531++bgaKa1wg0FG03bNAGpVhpQ+FY7bAUHcZHuh9tcOeCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bfcIsXdb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wenUuiP1; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1776057260; x=1807593260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=02NhDW33akjzLAWNzx2XiFmDusqBSljIwD6yvuajEy0=;
  b=bfcIsXdb5Z/60OJq0AIFMRkwpIFTrwDPXOeS3qVXsaiUfT5WEJIawNdF
   3TBja5soJAJJvYkwpqaxE71vFDfWt7cb1mQEBPHMmpRMDB2AP6PfAV7bE
   4tqnoBLCb5C8T4A6iM+IcBoP9CCBv4ZX3S+Jp0CKrSS3R9xohQvsqZZlw
   ooc6qv7xo6abHcqh3yJ9NJ8AXWv9sG93kFR924V6Bw+EV6FXXeQzWVI7a
   6AuAnV3Lv+5V2Cz4LPs2TIhe1lBexoLjZyzhj/r7o+5mkSinMxyPvETJN
   Usubcu7FCmJDGfuqt1zh0lk+OwVP04QSATDqhHs865dD8nMywOfitbEvO
   Q==;
X-CSE-ConnectionGUID: iLnIa0jtRHiqBisuZShuug==
X-CSE-MsgGUID: IB2yL5jyReyuODmTLKIjaQ==
X-IronPort-AV: E=Sophos;i="6.23,176,1770566400"; 
   d="scan'208";a="143301888"
Received: from mail-centralusazon11010018.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.18])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Apr 2026 13:14:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBGik7f+d0DxZc8JVd/bTLhjTvmYcuQS7JtZfmulRCULH+LFJLQIvh0ndHWIyAHlWBg0uu1uCNOyKd1V4+2uk1yUwbb1R3WkKqX6pWp0eJ7x7Oo287lVxgzo2RSb+2kUtaTD5oT6oNxs1G7M6kCvRRx9Jf3MtUnasQxPODysiiMrfeFUuPdD7UQp05g2g8awfEx3uauuq6rOfja9AaGDL9AnGveEmR1455EQqDMYV4MTrhtLW9lXWvyP94n/Oe/Cm7iXmPbmw29FLZfmdQVoBgOTsnwP5X0nqIXBlzn+wpo0LpaFo6+czbqmqjp4Czofz+v85z53Gb/VWPqcAZOmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSgGUKmpKM3R6QreaeHdJC89VbkoDKYDEEYyND56y1Q=;
 b=kJe99gm2NAHf8Sr9zCaNw8irGbFrutgm/Eq3PYDCbx1K6RmX11qIjp5hjvU1IfQqnJOr7zSw2j24MbI4SCkIZCwugjiFV5rS2MTECld8TYP8tbd2Y0nSfiaM1nhQWqAwAkkbPCQ3p3bIF9fZ8WL1X+bT7eZw/06InjJLjegsNo5IXVECR0/m4LkxdGw/N5dsDWEU+LixZU0c6gZ7CxRt5d/fL5JyuR9fNQOxo3kJawjsB03739zYUNznPmSvbXzn2Yz4jYkTHBcr4C3miv2nKf6PmswHN3WQKOs9Kr73rkzT9/yxLDwDhBCD5/HwOqheEqM5Yh/kCIAcSr9wujHvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSgGUKmpKM3R6QreaeHdJC89VbkoDKYDEEYyND56y1Q=;
 b=wenUuiP1tnx6vsAE+f84fqKVg6IM4RedNI1QcNI4zunqD7JFoIODBQUpyy53gp8kOcsyE4FL+lo4S6wruomD4GrLH4un8geQrPjfUmjVYw3254ne3dSJZ7rlXYkgPCK0pmyCmEOJGOTbiv7384v2w0gmf7++FxHWboOcesiS6uY=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6542.namprd04.prod.outlook.com (2603:10b6:5:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:14:10 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:14:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet
	<corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann
	<arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y .
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Bodo Stroesser
	<bostroesser@gmail.com>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand
	<david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn
	<jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v4 19/21] uio: replace deprecated mmap hook with
 mmap_prepare in uio_info
Thread-Topic: [PATCH v4 19/21] uio: replace deprecated mmap hook with
 mmap_prepare in uio_info
Thread-Index: AQHcywRaIQ1vSsERjkyE4ZP7p41s1g==
Date: Mon, 13 Apr 2026 05:14:08 +0000
Message-ID: <adx2ws5z0NMIe5Yj@shinmob>
References: <cover.1774045440.git.ljs@kernel.org>
 <157583e4477705b496896c7acd4ac88a937b8fa6.1774045440.git.ljs@kernel.org>
In-Reply-To:
 <157583e4477705b496896c7acd4ac88a937b8fa6.1774045440.git.ljs@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6542:EE_
x-ms-office365-filtering-correlation-id: 924bc42a-e6ca-4eff-6855-08de991b7d9f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 TGHJ/mwrxYCIo9VVnIfMtLV1feIQCFS+XBCgg+Q6SDLM0+vMjuDc99RYL5s0MyWebK3RtRTv2li5px5QAkuyUkC9+aKbs1B7OYtXp0nDpeN243xekm4cMIFJ5aqFq36ZHGguanjZll2lFrPV33LZWBhlIxAERdrUwJAwhjUq0iCF+F3fzA+k7SgE3UmvhXnJ+K4aG7hHh1MoFYWE9N38i7freHXKRw6HXuLDweMNI9ECjQEyg7/TxuGzg8xpp1Yp+wTWb/C/mwz71SMyrYnJybSLuyVUabK1x4HQ6nLkNgfis7ENzxs3I99uJNC/j4wQwV3aZPHq2hq7QBdl0Ij3CchVN/0KMMC/bSErRkG7z+NMbZtpWQ7AiV93vMuyIpTy1n5qF/p+oJPeTMGTDrFGrST8yDGkGTOGwMXFZEOjACuoj5GJ6SzFOsx7zXZwcLYnq5lCs2krcdYDpqdV9UJpGgKXe/ftI7y6knmHUQLJ7cKvY8NYPViWq4D8G9bbpCj+/RnZdCmnzX579H7/UO4MsmJQ9OhPdtbAQJS4Q4Vrj6RKG9ndxIFnVc8iDK3AqAltxDMwLOkwqXpg8suILvlcYMJYRYgQGCsmONeHa/tfe3/CIQ6cw9PE2sAgKbn9bdDvmAQZMerugJ59X4OXfr/PMYnvdWtYN94k22etA9gED3MHohXLXhJbmcK0MSX+7yKbebi/L2mF+05lwYjUXVsbKu6EDvIG4MbefLa/+hBPxvDEvVVzzYLBAwLG2oe2xwlB8mp7fDH+qXh9OImJQDXuaCy2WQI5fh0uo7t3wdzpnCM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y5w/f1bAyv5/GJIoM+hXs7GiQqeqyyIPtlZbNTtHPrwL0/X35CsIDkFxEMSD?=
 =?us-ascii?Q?RxiKho3fZYhhK0ND1vrVzKu0yf2APFYqir6iDxgvZbRbrZXy3pPOTt85lms3?=
 =?us-ascii?Q?JAOe31ZmQFr7sHg3OVDOmks1WmQV5xE4leAnv27Igce2s/5+M6Rst1qHl1Cj?=
 =?us-ascii?Q?GFg7l7oV0InXi5dZo/5jdpaOJ51uGMT0G1qVhkWZKMwROPlKZdQ4jgRL1+Bg?=
 =?us-ascii?Q?Lg0w3uyK+NwGlgtHJFZXCnkOOn1pVMbu19ZmKn1DaEgSg4A9jqffqyWxYMQs?=
 =?us-ascii?Q?3lUKkJeWn3ui/a0NazzXQABaqZqtir/0d2yzSMEI5MK8ZRvWzzyANOnLC2Va?=
 =?us-ascii?Q?KYkyxJptZ+Su1/jxY1m4pmfghUBiAOtGC39LzxrDdk3RAeoZ6WA+pfCKmESA?=
 =?us-ascii?Q?0qttkAXpuh1l8nfPL/DmLVtAbAIKsXLp/jTUfGL/43zM3JBV/ZjRcf1VX3fk?=
 =?us-ascii?Q?p6QKEING8FXHL4LqxhrkDXmnPH0T4CylIHerEL5g6+r4adKlJF6xHScU7H8s?=
 =?us-ascii?Q?nYc7fGSfo3XtJGDRE5Wi+2066uG/DHJOY3yrJJOsmkS6IJHDo8YuzsFiv9dK?=
 =?us-ascii?Q?AjPpCMkymeO0pcrPH02GFXyR/Eig0Y7Y8s5O+mTDBPXrJhoN+bMxluTe7mqy?=
 =?us-ascii?Q?wXntsm4xQKoJ8Sx5M9qbKMwUDll+IEKvTzmk3qi07TLtA3uuJtFNydNudmn1?=
 =?us-ascii?Q?OdFaPZieBWuOLxVO1fFyvhxxlZeoJzPILSJfxGuSar4wpDRbnAtKVB4Sb8/o?=
 =?us-ascii?Q?vEKezaVmvtAef8BLAQ8NA3VDbKvut/VMJuAZewBfsTiI8RWZXdYsFeFRUmjS?=
 =?us-ascii?Q?vk61l65ZPWCDSvSzk7ch9uuU/tqpryM8RDeLBl115DworcLcuEk6WRjfM/Df?=
 =?us-ascii?Q?o0Peze4kX4lTvpVctqDHV8l9hEI0VzlIJcRs4r/IxVJKRJ6GNSYy/kh5j7wC?=
 =?us-ascii?Q?lO2jdnEN/JkMMK4yom9GkYL4oH6ChyNAN+ZTphKxqEvlNt/ctAqMQusY8Cv4?=
 =?us-ascii?Q?oJb2WvEcJlEV9TJt8otGiPa8hN2Y4i6769jLxTaTcj+XWtRoYV/t7YoUr9Uu?=
 =?us-ascii?Q?dBCjppZn7pItfdwg8W5ws3CP+npQQJxw+NzPD6iWAS2u/ShMKNxOGU7oYia6?=
 =?us-ascii?Q?VZzXe/8Rnl7zWAxI1idNYUM6ZCBp0XDc/k8fMT8xPJuKs/JwnTtHNGmJ4JJ8?=
 =?us-ascii?Q?bB6NxtUN24lOf2C9rH0vc3vsBRms7UGyQSrVJV+pchMRWRUWK9OxSGR0Yxgl?=
 =?us-ascii?Q?mOTs6CE4ijugpzXE65wsif7RxROiLRZZ7OEK6dD9KagYhsXHublhRO7h8MOr?=
 =?us-ascii?Q?iua2T+wsIy78bNLADVmDwWi0uhHlOn4YfZZyN03LmT4aDrqxej9fg9TYwSof?=
 =?us-ascii?Q?h1UCXpHEbYlvGwRgILNv7evQx+ywOazssryyDcaVqYeuml5QdWZVT5EfKvWD?=
 =?us-ascii?Q?BcyXdUmxhyNunlBw6r0VhB84ecAR7Vwtf12Vf9yj376Q8i8wsT4eTR0U1E0X?=
 =?us-ascii?Q?Erh3YW0FVLt0Vfb4Ez5Noe+dDR9NTNws2ouWIVY5xDUHylv/xFxsCrfNsgq0?=
 =?us-ascii?Q?PupetZZ9ePBxUaYXschHFrHaRGOEbUVwKFG4YowpNJxn7Xfl5BRm2Lwh/hLr?=
 =?us-ascii?Q?1sBLOr6mgtvqNvB06oGbAD9JX284ARodUb1qz30pFgn2gqr7aTOO3BgJwVkr?=
 =?us-ascii?Q?MBYALvMbuT90ONoy8P7zqWYQiXoL3fEiNlqSkrvLkGnrNi5Yla4CJDP/YdtF?=
 =?us-ascii?Q?KM+4/hXcFJXC5ibkzCd4ZABVZf93FYg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6ABB590337D4464EB7C9A6E30FB74C3E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	u23cXnKCHP7ESOZHvffHpzb8lqOt3IMisAJA0sErW07R2e1AxbIBQcO+S8na3xzYzSrnWUWuwVh+7UmbIwmGAh8kZiGPxLAZ4VOZ8koraOorlsbnQBDw0BJkUpbcKoJr/atR9W/or8QNq+RQ2JifEwIO1cLqny+hoUNucfe1+muMMPkKsJlkkp/B1DMw2OB2Ig3AJrLlAiOkTXBKMg2m3q4oIruzra5HdxFL6mIy68IhkbWKat9hQVxVLaCOVg3GzIbaoA4jYRWVojsv4Gfc2WWeNTpXO3Q//ZqmZOnoNbP55b1XFaz/b7gojKMo+IeIzoYDEdBlS6cUV2lpfelXbA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yqkx+iiYG6YY3ASI8w8o4STVcP94Ta7eI19c47PTMnSe6GijbxjQjcYY9UHUwaz7SEG0MAPeDNftmNvDSSUbdFocyPPr8aVPhvA3hhCRydTE/KGbuDO/GDZFAWjz+hTDGJ8oUJz6b2WtvNryia5K/hQlkOA0w3yEtecad+wfFvsONib5nGu5TGNIqE0Uycsb1Qsyux2r8cpyhTRCBkluFqDMYMyWrU985IuSJU63UVmT/2ElFKI/5qTRMs1ZItdik/AOLr1mf/p20eKoYOSPAHaNwn1fOiUKb1QZ/yTAnRdE7SLNlD4iXva061Cqgf3xfQDC9ho5FlPUsn0X1MCxBLfsGGB9LE9brezTFMFtRuQNtcKJcvEuhlyrxrBb+vIcKBdD4nkm26Km5Mbl0/L5VBsAKallvilEWCltQktjQ487SblQJ1DI5khvsiikstBO/ruIG5cjaru6ZY+YObUsc6XaoTVZA0wXhs91Lm2uoSmpqSFSbLF/YCIejeNRr7mZs2n1C9pX/mSQeJ67gEJE3GiQzA/exxYs1BIsaOP87bWxDQqRNe32O0BILV0TwhNnnpzsmRRlSKlHri9NYv06Wy7PCYIZHZ7OBsgu+ztuul5MoC0/lO4dVnQNhzwRck0/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924bc42a-e6ca-4eff-6855-08de991b7d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 05:14:08.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IjSWQWK1Mrt35AgAaFFG+AzoUGcL/Yyfr4M3NG1ELl4YzYp7bUPtoERjngRDl++vwzFUwDnuXtgw5+tqOP8fXUq23IJwwthsgJhC7fAZ7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6542
X-Spamd-Result: default: False [3.84 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10123-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_MIXED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 497603E76D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mar 20, 2026 / 22:39, Lorenzo Stoakes (Oracle) wrote:
> The f_op->mmap interface is deprecated, so update uio_info to use its
> successor, mmap_prepare.
>=20
> Therefore, replace the uio_info->mmap hook with a new
> uio_info->mmap_prepare hook, and update its one user, target_core_user,
> to both specify this new mmap_prepare hook and also to use the new
> vm_ops->mapped() hook to continue to maintain a correct udev->kref
> refcount.
>=20
> Then update uio_mmap() to utilise the mmap_prepare compatibility layer to
> invoke this callback from the uio mmap invocation.
>=20
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Hello Lorenzo, since two weeks ago, I observe a failure during my kernel te=
st
set targeting Linux for-next branch. On failure, kernel reported a WARN at
__vma_check_mmap_hook [1]. I bisected and found that this patch is the trig=
ger.
Here I share my observations of the failure. Actions or advices for fix wil=
l be
appreciated.


The failure happens when TCMU device is set up with targetcli. When tcmu-ru=
nner
is running, the command lines below should successfully create a backstore =
for a
TCMU device, but it fails.

  $ sudo targetcli
  targetcli shell version 3.0.1
  Copyright 2011-2013 by Datera, Inc and others.
  For help on commands, type 'help'.
 =20
  /> cd /backstores/user:zbc
  /backstores/user:zbc> create name=3Dtest size=3D1M cfgstring=3D@/tmp/tmp.=
img
  UserBackedStorageObject creation failed.

On failure, tcmu-runner reports mmap failures:

  2026-04-13 12:23:49.271 1103 [CRIT] main:1302: Starting...
  2026-04-13 12:23:49.461 1103 [INFO] load_our_module:575: Inserted module =
'target_core_user'
  2026-04-13 12:23:49.480 1103 [INFO] tcmur_register_handler:92: Handler fb=
o is registered
  2026-04-13 12:23:49.486 1103 [INFO] tcmur_register_handler:92: Handler zb=
c is registered
  2026-04-13 12:23:51.202 1103 [INFO] tcmur_register_handler:92: Handler rb=
d is registered
  2026-04-13 12:27:24.522 1103 [ERROR] device_open_shm:523: could not mmap =
/dev/uio0
  2026-04-13 12:27:24.550 1103 [ERROR] device_open_shm:523: could not mmap =
/dev/uio0

The failure was found with user:zbc handler. I confirmed that the failure i=
s
recreated with fbo handler also. Then, this failure looks common for all TC=
MU
users.

At the failrue, kernel reported the WARN at __vma_check_mmap_hook [1]. The =
line
1287 in mm/util.c reported the WARN:

  1284 int __vma_check_mmap_hook(struct vm_area_struct *vma)
  1285 {
  1286         /* vm_ops->mapped is not valid if mmap() is specified. */
  1287         if (vma->vm_ops && WARN_ON_ONCE(vma->vm_ops->mapped))
  1288                 return -EINVAL;
  1289
  1290         return 0;
  1291 }
  1292 EXPORT_SYMBOL(__vma_check_mmap_hook);

When I reverted the commit from the kernel tag next-20260409, the failrue
disappeared.

If other information is required for fix, please let me know. Thanks in adv=
ance.


[1] dmesg

WARNING: mm/util.c:1287 at __vma_check_mmap_hook+0x61/0x90, CPU#0: tcmu-run=
ner/1332
Modules linked in: target_core_pscsi target_core_file target_core_iblock xf=
s target_core_user target_core_mod rfkill nft_fib_inet nft_fib_ipv4 nft_fib=
_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_=
ct nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_securit=
y iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_man=
gle iptable_raw iptable_security nf_tables ip6table_filter ip6_tables iptab=
le_filter ip_tables qrtr irdma intel_rapl_msr intel_rapl_common ice intel_u=
ncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common libi=
e_fwlog nfit sunrpc gnss idpf libnvdimm x86_pkg_temp_thermal libeth_xdp int=
el_powerclamp libeth ib_core spi_nor mtd coretemp kvm_intel kvm i40e iTCO_w=
dt irqbypass intel_pmc_bxt rapl ses vfat intel_cstate libie fat intel_uncor=
e libie_adminq enclosure i2c_i801 spi_intel_pci i2c_smbus spi_intel lpc_ich=
 wmi joydev mei_me ioatdma acpi_power_meter acpi_pad mei intel_pch_thermal =
dca fuse loop dm_multipath nfnetlink zram
 lz4hc_compress lz4_compress zstd_compress ast drm_client_lib i2c_algo_bit =
drm_shmem_helper drm_kms_helper nvme drm mpi3mr nvme_core scsi_transport_sa=
s nvme_keyring nvme_auth scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkcs8_key_pa=
rser i2c_dev [last unloaded: null_blk]
CPU: 0 UID: 0 PID: 1332 Comm: tcmu-runner Not tainted 7.0.0-rc6-next-202604=
01-kts #1 PREEMPT(lazy)=20
Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.5 05/18/2021
RIP: 0010:__vma_check_mmap_hook+0x61/0x90
Code: 00 00 00 00 fc ff df 48 8d 78 10 48 89 f9 48 c1 e9 03 80 3c 11 00 75 =
2a 48 83 78 10 00 75 0b 31 c0 48 83 c4 08 c3 cc cc cc cc <0f> 0b b8 ea ff f=
f ff eb ee 48 89 04 24 e8 6d 4c 1f 00 48 8b 04 24
RSP: 0018:ffff8881391f7488 EFLAGS: 00010282
RAX: ffffffffc2abca40 RBX: 0000000000000000 RCX: 1ffffffff855794a
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffffffc2abca50
RBP: ffff8881391f76a0 R08: ffffffffa10016e9 R09: ffffed102723ee44
R10: ffffed102723ee45 R11: 0000000000000000 R12: ffff8881391f78e0
R13: ffff8881391f78f0 R14: ffff88810d1ec780 R15: ffff8881391f7a78
FS:  00007f154f1a9840(0000) GS:ffff888e9b440000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5efd40fe88 CR3: 000000010cfbf005 CR4: 00000000007726f0
PKRU: 55555554
Call Trace:
 <TASK>
 __mmap_new_vma+0x116e/0x18d0
 ? __pfx___mmap_new_vma+0x10/0x10
 ? vma_merge_new_range+0x495/0xa00
 ? __pfx_vma_merge_new_range+0x10/0x10
 ? lock_acquire+0x126/0x140
 __mmap_region+0x651/0xa00
 ? __pfx_process_measurement+0x10/0x10
 ? __pfx___mmap_region+0x10/0x10
 ? __lock_acquire+0x55d/0xbd0
 ? __lock_acquire+0x55d/0xbd0
 ? lock_is_held_type+0x9a/0x110
 ? mas_find+0xc9/0x690
 ? arch_get_unmapped_area_topdown+0x2a7/0x890
 mmap_region+0x3c2/0x4c0
 ? __pfx_mmap_region+0x10/0x10
 ? security_mmap_addr+0x54/0xd0
 ? __get_unmapped_area+0x18c/0x300
 ? __pfx_uio_mmap+0x10/0x10
 do_mmap+0xa26/0x10f0
 ? lock_acquire+0x126/0x140
 ? __pfx_do_mmap+0x10/0x10
 ? __pfx_down_write_killable+0x10/0x10
 ? __lock_acquire+0x55d/0xbd0
 vm_mmap_pgoff+0x218/0x3a0
 ? __pfx_vm_mmap_pgoff+0x10/0x10
 ? __fget_files+0x1b4/0x2f0
 ksys_mmap_pgoff+0x229/0x570
 ? clockevents_program_event+0x144/0x370
 do_syscall_64+0xf4/0x1560
 ? do_syscall_64+0x1d7/0x1560
 ? __lock_release.isra.0+0x59/0x170
 ? do_syscall_64+0x34/0x1560
 ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
 ? do_syscall_64+0x34/0x1560
 ? trace_hardirqs_on+0x19/0x1a0
 ? do_syscall_64+0xab/0x1560
 ? clear_bhb_loop+0x30/0x80
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f154f5728dc
Code: 1e fa 41 f7 c1 ff 0f 00 00 75 33 55 48 89 e5 41 54 41 89 cc 53 48 89 =
fb 48 85 ff 74 41 45 89 e2 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 7c 5b 41 5c 5d c3 0f 1f 80 00 00 00 00 48 8b
RSP: 002b:00007ffeb6ac04f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f154f5728dc
RDX: 0000000000000003 RSI: 0000000040800000 RDI: 0000000000000000
RBP: 00007ffeb6ac0500 R08: 000000000000000c R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 000000001ddac980 R14: 00007f154fa629c0 R15: 00007f154fa62940
 </TASK>
irq event stamp: 62665
hardirqs last  enabled at (62679): [<ffffffff9e1cd23e>] __up_console_sem+0x=
5e/0x70
hardirqs last disabled at (62698): [<ffffffff9e1cd223>] __up_console_sem+0x=
43/0x70
softirqs last  enabled at (62692): [<ffffffff9dfc5d01>] handle_softirqs+0x5=
c1/0x8b0
softirqs last disabled at (62721): [<ffffffff9dfc6152>] __irq_exit_rcu+0x15=
2/0x280
---[ end trace 0000000000000000 ]---
scsi host74: TCM_Loopback

