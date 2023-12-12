Return-Path: <linux-hyperv+bounces-1324-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E67E80F55C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFE9B20D5B
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 18:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F55B7E780;
	Tue, 12 Dec 2023 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="GFhgGVHY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC479B;
	Tue, 12 Dec 2023 10:18:12 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCAq2sE004992;
	Tue, 12 Dec 2023 10:17:40 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uxp52t0bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 10:17:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXVh0wDDW0A1Cyz00jVHpD0bu3Pb/cSDvlBMO7LjSgtFH76kn9fWNJiSeW7qL6ZMZCHrOuVUK8lWYwcW1FRzYqwCrBZKPgkdkCgaSuwLtgMk3Zohn2c203phmkKvcJJRqmzkDruSRwaeONQAlKaU3TYOZTDfngF82jngoKH4MRofRZSM5qtHLdrM4cMgqXPWdELDo6hoZz9gVuvHHwMJu1ufanIVDjkXLpCIR7C1DlCyHU2FYp7tAyoqqNkySxzY8sgYHHMSIQRdjTqhDsYWzk75ITnObTW1ozvO1RGahwb9jWf7jomdN3s2QLT4ItEoJ+rNWF0oTjApLNooiowQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiD8c9QCYTxQMRq/KJIfN03EB3fHQnmAvaikZk409Ew=;
 b=IZfGCgy0GI1Xa8r1z189RXYWtAb560YmA8C3c3t/RAS+pHSWKaJ5+CvfxacHEnhlXefkuMPFRFmddGKyQnv0Bb65WF4efsiuf0SAJFBCs1vqRvU7F5p2zdxS/MtxbwW2bAw+6rgTF0tBtAVxE8FAYiQgIq8c6Fu5CPWfUoK5/648keGZ3MOo8+epIBjP5a0C0n3cbfgPeaKiy6UNhPJXcAIpyiW2YmO6DR5idj9OlDNb3kG7OG/6mt7ytv9aFQXylX3g6Hf7SA8A4IPuZxjINlXP3a0+5InfaZl03x11AAkUaK0pTwdokJdQGmHVvg7vYMYivbWhj6xFnPVm1z83SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiD8c9QCYTxQMRq/KJIfN03EB3fHQnmAvaikZk409Ew=;
 b=GFhgGVHYjqvKpu+SBwyloRQyTx/zrvMPlU8AdX1d18XaH+iRcAnQeQ4GTZxhBze5HTj3ZyAlLiVdNx2NJQZrnfVIuDvxUSmmZXnPDJN/asybafVk/FsYMR2vbfph3cAIbve+XQOPsTtMPWjULqxLkWxFpUeqjJwHodfktFQDnj0=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by LV8PR18MB5653.namprd18.prod.outlook.com (2603:10b6:408:191::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 18:17:36 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::6a4f:cb8d:70fd:ef2]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::6a4f:cb8d:70fd:ef2%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 18:17:35 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "longli@microsoft.com" <longli@microsoft.com>,
        "yury.norov@gmail.com"
	<yury.norov@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "schakrabarti@microsoft.com" <schakrabarti@microsoft.com>,
        "paulros@microsoft.com" <paulros@microsoft.com>
Subject: RE: [EXT] [PATCH V5 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Thread-Topic: [EXT] [PATCH V5 net-next] net: mana: Assigning IRQ affinity on
 HT cores
Thread-Index: AQHaKb25Y4Hq+pwMvEiOPEvwfbaJv7Cl8YWw
Date: Tue, 12 Dec 2023 18:17:35 +0000
Message-ID: 
 <SJ0PR18MB5216C6E41006057839D3C01BDB8EA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: 
 <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: 
 <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYjdjM2Q1MTAtOTkxYS0xMWVlLWI3MDAtODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XGI3YzNkNTExLTk5MWEtMTFlZS1iNzAwLTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iNzY4NCIgdD0iMTMzNDY4Nzg2NTM3ODU5?=
 =?us-ascii?Q?MDc5IiBoPSJ3a01nSGw1Q0ZNaWxiWWd1akJLNEU2WUJJd1E9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCZ1dBQUFI?=
 =?us-ascii?Q?Q0RGNkp5M2FBU2JWQXRsL0JDbFpKdFVDMlg4RUtWa1pBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQURvR0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQTlSZW5Md0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFB?=
 =?us-ascii?Q?RzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFBeUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01B?=
 =?us-ascii?Q?ZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtB?=
 =?us-ascii?Q?SE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFY?=
 =?us-ascii?Q?d0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3?=
 =?us-ascii?Q?QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?UUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFC?=
 =?us-ascii?Q?ekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6QUd3?=
 =?us-ascii?Q?QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0FaUUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFI?=
 =?us-ascii?Q?UUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJ?=
 =?us-ascii?Q?QVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?YmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhB?=
 =?us-ascii?Q?R3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFY?=
 =?us-ascii?Q?d0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNn?=
 =?us-ascii?Q?QnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlB?=
 =?us-ascii?Q?QUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNB?=
 =?us-ascii?Q?R1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdCdkFH?=
 =?us-ascii?Q?UUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdr?=
 =?us-ascii?Q?QVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0Jo?=
 =?us-ascii?Q?QUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FY?=
 =?us-ascii?Q?d0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3Qm5B?=
 =?us-ascii?Q?R3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0Jm?=
 =?us-ascii?Q?QUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFi?=
 =?us-ascii?Q?QUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElB?=
 =?us-ascii?Q?YndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRBQnlB?=
 =?us-ascii?Q?R2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3?=
 =?us-ascii?Q?QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFIVUFj?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBT2dZQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQUFBQWFCZ0FBR1FBQUFCZ0FB?=
x-dg-reffive: 
 =?us-ascii?Q?QUFBQUFBQVlRQmtBR1FBY2dCbEFITUFjd0FBQUNRQUFBQUFBQUFBWXdCMUFI?=
 =?us-ascii?Q?TUFkQUJ2QUcwQVh3QndBR1VBY2dCekFHOEFiZ0FBQUM0QUFBQUFBQUFBWXdC?=
 =?us-ascii?Q?MUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0IxQUcwQVlnQmxBSElB?=
 =?us-ascii?Q?QUFBd0FBQUFBQUFBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QmtB?=
 =?us-ascii?Q?R0VBY3dCb0FGOEFkZ0F3QURJQUFBQXdBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3?=
 =?us-ascii?Q?QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhBY2dCa0FITUFBQUErQUFB?=
 =?us-ascii?Q?QUFBQUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCdUFHOEFaQUJs?=
 =?us-ascii?Q?QUd3QWFRQnRBR2tBZEFCbEFISUFYd0IyQURBQU1nQUFBRElBQUFBQUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUhNQWNBQmhBR01BWlFCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQVBnQUFBQUFBQUFCa0FHd0FjQUJmQUhNQWF3QjVBSEFBWlFC?=
 =?us-ascii?Q?ZkFHTUFhQUJoQUhRQVh3QnRBR1VBY3dCekFHRUFad0JsQUY4QWRnQXdBRElB?=
 =?us-ascii?Q?QUFBMkFBQUFBQUFBQUdRQWJBQndBRjhBY3dCc0FHRUFZd0JyQUY4QVl3Qm9B?=
 =?us-ascii?Q?R0VBZEFCZkFHMEFaUUJ6QUhNQVlRQm5BR1VBQUFBNEFBQUFBQUFBQUdRQWJB?=
 =?us-ascii?Q?QndBRjhBZEFCbEFHRUFiUUJ6QUY4QWJ3QnVBR1VBWkFCeUFHa0FkZ0JsQUY4?=
 =?us-ascii?Q?QVpnQnBBR3dBWlFBQUFDUUFBQUFBQUFBQVpRQnRBR0VBYVFCc0FGOEFZUUJr?=
 =?us-ascii?Q?QUdRQWNnQmxBSE1BY3dBQUFGZ0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FY?=
 =?us-ascii?Q?d0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFH?=
 =?us-ascii?Q?NEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFC?=
 =?us-ascii?Q?VUFBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5QUc4QWFnQmxBR01B?=
 =?us-ascii?Q?ZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxB?=
 =?us-ascii?Q?R1FBWHdCaEFHd0Fid0J1QUdVQUFBQmFBQUFBQUFBQUFHMEFZUUJ5QUhZQVpR?=
 =?us-ascii?Q?QnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJ?=
 =?us-ascii?Q?QVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJs?=
 =?us-ascii?Q?QUhNQUFBQWdBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCaEFISUFi?=
 =?us-ascii?Q?UUFBQUNZQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR2NBYndCdkFH?=
 =?us-ascii?Q?Y0FiQUJsQUFBQU5BQUFBQUFBQUFCdEFHRUFj?=
x-dg-refsix: 
 =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBR01BYndCa0FH?=
 =?us-ascii?Q?VUFjd0FBQUQ0QUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdrQVl3QjBBQUFB?=
 =?us-ascii?Q?WGdBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxB?=
 =?us-ascii?Q?R01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdVQWJn?=
 =?us-ascii?Q?QjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFHd0FBQUFBQUFB?=
 =?us-ascii?Q?QWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1?=
 =?us-ascii?Q?QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFi?=
 =?us-ascii?Q?QUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3QmhBSElBYlFBQUFI?=
 =?us-ascii?Q?SUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFC?=
 =?us-ascii?Q?akFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRB?=
 =?us-ascii?Q?ZEFCcEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5B?=
 =?us-ascii?Q?RzhBYndCbkFHd0FaUUFBQUZvQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdV?=
 =?us-ascii?Q?QWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFB?=
 =?us-ascii?Q?QUdnQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0Fa?=
 =?us-ascii?Q?UUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdVQWN3QjBBSElBYVFCakFI?=
 =?us-ascii?Q?UUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZBR0VBY2dC?=
 =?us-ascii?Q?dEFBQUFLZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWRBQmxBSElB?=
 =?us-ascii?Q?YlFCcEFHNEFkUUJ6QUFBQUlnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNB?=
 =?us-ascii?Q?RjhBZHdCdkFISUFaQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|LV8PR18MB5653:EE_
x-ms-office365-filtering-correlation-id: 0069e2ce-f91d-4658-989f-08dbfb3e9de1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +345hiZHw4j6UIRDfJ1CGKaN8xwBexOmN1c4NjSmskkR+VHnHZ7DFF3xefGcbpZ3xEGb84p3eBpg3mnha6MFF0X+8324nqLjJAsfo9D/xFgueZ+S/Zm1S+JEUQrK1YneWJM0ERxLKt+Kn9gVC8nWN6K6rkCzdv9WU/bP9rotH4650/jC9cRJ9A/Gf2TXTrTCpg02nzuDlctn1z2wyrIvNDpgyUAQc26376ab25jHx4iBNgz5SJk27kf5nlPa2SHe6HP1L+yYd2cyBGvA+N4Q2eMgnI64UngYBotEsea0UR9zXHkHnkcpDHdXie9uDxcg8CAjRFHjSpnToQJUHbNexUS3qVF4R/CxjldkeaqOFME7j7asgFkHD9zwCapGtFEKElfjy+E5kaRaX7F1P5jbUzGZQZ3xkxjU6udCvto5b3+H+MtcXEtpB9ei0rrXUkyjprPJmijsntURsjMDof8ezjX4vBtR0js62kfk/GUEG5yX+jLgBDouLhJCHc2peBkrWydSamTS+6aP/Qo+eaU0GavLxPJw72oZfNogZdnJ2EtRtBTjRZfdCL1PbbSV9HRKHD/6wqKBfrcyQ931zj6ELsWOQccBrDtF0NONCywzhdtXPeYKBiBE66M8DbrdG2NX
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6506007)(7696005)(9686003)(122000001)(8676002)(4326008)(5660300002)(52536014)(41300700001)(8936002)(7416002)(478600001)(2906002)(316002)(71200400001)(26005)(110136005)(38100700002)(86362001)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(33656002)(66946007)(921008)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+axC/A4b1SpmPzew7QzSg6AbXDQ89T0fxW6M7Kvk3ofnObhfmzGdwJ2M9IC1?=
 =?us-ascii?Q?yzZ4Oj3FMXZ//r0NtPucsmvjII/SC3JmMN63iJKvqcnEuUOaW/cG48Xnc6+M?=
 =?us-ascii?Q?U0TKBFUheyM/p/us87AC/K37QhtCIxx7Et+phdL9XxEN3Ujy1x62f5dpzqPG?=
 =?us-ascii?Q?E7Kdxtgcpx4MLzFaDPSKcbWniH5N94taluafsA5UpWeT+aAfqTs71DlnXQkC?=
 =?us-ascii?Q?obJyVMhuVfdlhEemeiI8yUxhK4NEGSQHmH5zY4fUTPZt3ezug9RxU95Aseo5?=
 =?us-ascii?Q?WC2bCsQiJ4YxEoLGsFsk38gTgg2Xrb7y4kKNUs8FtxkquKmYI5E7cSuyE9yt?=
 =?us-ascii?Q?GW52Pig+G21bCveYXhMcxG4J0IgH/IapZoII49gBzMRMHKb3/kLwmDARPk8m?=
 =?us-ascii?Q?+zR7hBdM9c8p+e48oWHZXW777jbKN7dyG2vU/oEFc3PIZVNlCPEg9yhWIik6?=
 =?us-ascii?Q?/9riy/pGGglgqHu7o/P/VVa3eXO0EPkdDpOtbHOyh2xQgBG9R8R9g1Eg3EFD?=
 =?us-ascii?Q?Jp7u/T9Z1/roiRirFwd7bIvGtEjPF0wCzPEVW85tPWetmYfgqBlCpwIosxFh?=
 =?us-ascii?Q?CXATeyB3DIBYocoHG8qb4FsDwogAOLD2b1oEKTpEHYx/VbGJnLeEKBjvigV0?=
 =?us-ascii?Q?hkqqY8gHhjdtPQhBIpkurfvBRaXA8N50vRHJhvqXKHM0SD/tLwt42xYaoy2g?=
 =?us-ascii?Q?0sVx9XdRQw2teSTNCBIdEq646gZsSp/ItyQPJHL6BN2xr5ZpgomHja5O8VWR?=
 =?us-ascii?Q?4AOvMglRDpv+7rZZu5xzzguFmSkxquRLsN9sgUtqlLn6IO2T5itSwp7hEf8+?=
 =?us-ascii?Q?UV4yuYNolIkohetUAK2U2jQiorqYSQrwc9M7Yq4UODrWMLjcRE8b/aiK5pO8?=
 =?us-ascii?Q?FzR8GUbbqHnnjU9fScmynJkBKkpErk/NyO4nRtWZM2oQhbXnSpw9bAuDM+KN?=
 =?us-ascii?Q?/JZx/HkMMow9jc5ftoluaeDSEAlwQgUp1+GDpTpti3UV0vZei/RxzzUOFAus?=
 =?us-ascii?Q?2mzfGJ/bJ1Y4bbYr335memwDvEewCUpKLvWh3V4P+UVjfO8DoJcJsOBaNxOq?=
 =?us-ascii?Q?gT6isPKqe2tIXHv/NTc5I+iDQnI9Z6H6UJ49sxE2JJSiasDMf4oRzviQJ4Za?=
 =?us-ascii?Q?Op3i7Li+YIxTYbJdFTz8IicL3YdOxzNrGBx9YbsYVY3J22QPecauZRj6OXEG?=
 =?us-ascii?Q?Cje4aYLY/FmLV3jK157OzxGX3To87AvDMtS49iPnECJCB8/r+jyJowod9RIn?=
 =?us-ascii?Q?3U/jz8h37KiMUOHB3wC/efUl/kr6+4B44pBe0xFqZF6joFM+w/S7R+meZaGo?=
 =?us-ascii?Q?ffbYXzgU0DqtqVPr9L/A0KyAPIRb/cYn8IytQFzAWo+l9hOxrcUAfezfpxQ0?=
 =?us-ascii?Q?8qJg68RUOlODMspA1GBm3L56F9kd1cs0pyIan3kgBmqpDgdb6BoW80uqamwt?=
 =?us-ascii?Q?C+dyG09+bBUtOhp4mS5zBPDij+k7l/Tv93/X4CQ7mUkUv5mhUxFwGxr8qrCJ?=
 =?us-ascii?Q?W9dXVBq5FBwIQbIemcFqOleCaSb3t035YvOR0RYN1+i/DZrM2RO8JdS8/flH?=
 =?us-ascii?Q?+pbpKGKXbOP2FNow7MZ9ZiXaoCQhYPqcZnhWF7i9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0069e2ce-f91d-4658-989f-08dbfb3e9de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 18:17:35.8191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHZjXPYLe8tk5e0Wm2sdx8m6Ynun0JJ1vhnDNNljJgKyq5lxgJ0HK9ncJ6YHKKve5smCA3sMPGDTEU2mlcVvEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5653
X-Proofpoint-ORIG-GUID: QFCfTF2Ak875sqp0xXzrpJa4NAniR7jb
X-Proofpoint-GUID: QFCfTF2Ak875sqp0xXzrpJa4NAniR7jb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Hi Souradeep,

Please find inline for couple of comments.

>+
>+	if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
>+		err =3D -ENOMEM;
>+		return err;
>+	}
>+	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL)) {
[Suman] memory leak here, should free 'curr'.
>+		err =3D -ENOMEM;
>+		return err;
>+	}
>+
>+	rcu_read_lock();
>+	for_each_numa_hop_mask(next, next_node) {
>+		cpumask_andnot(curr, next, prev);
>+		for (w =3D cpumask_weight(curr), cnt =3D 0; cnt < w; ) {
>+			cpumask_copy(cpus, curr);
>+			for_each_cpu(cpu, cpus) {
>+				irq_set_affinity_and_hint(irqs[i],
>topology_sibling_cpumask(cpu));
>+				if (++i =3D=3D nvec)
>+					goto done;
>+				cpumask_andnot(cpus, cpus,
>topology_sibling_cpumask(cpu));
>+				++cnt;
>+			}
>+		}
>+		prev =3D next;
>+	}
>+done:
>+	rcu_read_unlock();
>+	free_cpumask_var(curr);
>+	free_cpumask_var(cpus);
>+	return err;
>+}
>+
> static int mana_gd_setup_irqs(struct pci_dev *pdev)  {
>-	unsigned int max_queues_per_port =3D num_online_cpus();
> 	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>+	unsigned int max_queues_per_port;
> 	struct gdma_irq_context *gic;
> 	unsigned int max_irqs, cpu;
>-	int nvec, irq;
>+	int start_irq_index =3D 1;
>+	int nvec, *irqs, irq;
> 	int err, i =3D 0, j;
>
>+	cpus_read_lock();
>+	max_queues_per_port =3D num_online_cpus();
> 	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> 		max_queues_per_port =3D MANA_MAX_NUM_QUEUES;
>
>@@ -1261,6 +1302,14 @@ static int mana_gd_setup_irqs(struct pci_dev
>*pdev)
> 	nvec =3D pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
> 	if (nvec < 0)
[Suman] cpus_read_unlock()?
> 		return nvec;
>+	if (nvec <=3D num_online_cpus())
>+		start_irq_index =3D 0;
>+
>+	irqs =3D kmalloc_array((nvec - start_irq_index), sizeof(int),
>GFP_KERNEL);
>+	if (!irqs) {
>+		err =3D -ENOMEM;
>+		goto free_irq_vector;
>+	}
>
> 	gc->irq_contexts =3D kcalloc(nvec, sizeof(struct gdma_irq_context),
> 				   GFP_KERNEL);
>@@ -1287,21 +1336,44 @@ static int mana_gd_setup_irqs(struct pci_dev
>*pdev)
> 			goto free_irq;
> 		}
>
>-		err =3D request_irq(irq, mana_gd_intr, 0, gic->name, gic);
>-		if (err)
>-			goto free_irq;
>-
>-		cpu =3D cpumask_local_spread(i, gc->numa_node);
>-		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
>+		if (!i) {
>+			err =3D request_irq(irq, mana_gd_intr, 0, gic->name, gic);
>+			if (err)
>+				goto free_irq;
>+
>+			/* If number of IRQ is one extra than number of online
>CPUs,
>+			 * then we need to assign IRQ0 (hwc irq) and IRQ1 to
>+			 * same CPU.
>+			 * Else we will use different CPUs for IRQ0 and IRQ1.
>+			 * Also we are using cpumask_local_spread instead of
>+			 * cpumask_first for the node, because the node can be
>+			 * mem only.
>+			 */
>+			if (start_irq_index) {
>+				cpu =3D cpumask_local_spread(i, gc->numa_node);
>+				irq_set_affinity_and_hint(irq, cpumask_of(cpu));
>+			} else {
>+				irqs[start_irq_index] =3D irq;
>+			}
>+		} else {
>+			irqs[i - start_irq_index] =3D irq;
>+			err =3D request_irq(irqs[i - start_irq_index],
>mana_gd_intr, 0,
>+					  gic->name, gic);
>+			if (err)
>+				goto free_irq;
>+		}
> 	}
>
>+	err =3D irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
>+	if (err)
>+		goto free_irq;
> 	err =3D mana_gd_alloc_res_map(nvec, &gc->msix_resource);
> 	if (err)
> 		goto free_irq;
>
> 	gc->max_num_msix =3D nvec;
> 	gc->num_msix_usable =3D nvec;
>-
>+	cpus_read_unlock();
> 	return 0;
>
> free_irq:
>@@ -1314,8 +1386,10 @@ static int mana_gd_setup_irqs(struct pci_dev
>*pdev)
> 	}
>
> 	kfree(gc->irq_contexts);
>+	kfree(irqs);
> 	gc->irq_contexts =3D NULL;
> free_irq_vector:
>+	cpus_read_unlock();
> 	pci_free_irq_vectors(pdev);
> 	return err;
> }
>--
>2.34.1
>


