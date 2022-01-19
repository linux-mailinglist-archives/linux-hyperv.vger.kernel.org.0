Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C226B49434F
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jan 2022 23:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357634AbiASW5v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jan 2022 17:57:51 -0500
Received: from mail-eus2azon11021014.outbound.protection.outlook.com ([52.101.57.14]:24187
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357621AbiASW5t (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jan 2022 17:57:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcAWDQmxwiaHu5EzuCkpuZLYghcKW3EvdXFbRMAXlc8qjwicDPa3Wt5L/1/S8xJ7eXJ8PrqZhsgH8od8IF45Bolb7SfiXfiGtc+ZUq8+4nFDfAxGGp5E/npSYtpfBDNb/honYettwxIxmGoqnbyNTlPpC0eRWTZXHvPv6vY/rJsWqrrxKqA4sgwwFXptA933z16Y67tmNEbDHJMQfj1OsLKTk/i2rd1otykOUz1pHgqmNmLjkHUDdZiRVTapDoMkUu/hkyAuhppStjtQz8XRggPTeWS2//jb6IbcIDtdBxr9y+HDwVRHAihqblYfFLrutzuvp3+oXBu1Tn3gaCC2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DBzD9mbhGQeqkWg4I7mbI1E58jgucOORdcXKyEajIE=;
 b=Cn0RbdaHjq/VMqlwUhKJbRqUC6LKkDxr4k+v6iwgJKOKsklO+bfNFy4hJndTMv++Tipl1LQM6d7uB3bQr5fLFWncFF7P9BDMGou/YMzYnlp1skLhd3Ic6E+pvUtS8tDOHdxLsFzZ1nADXrZX4051VnKNMyU8VGXVSF1mVg5Xje3n/h+DBqHAKSH1zK4kV73OsE/0Rwo8pdfMJ9Ym5IRV9RLroOcm78oBza4vazbx8DF7gLqwb98CduxezS+GC2DngWDobq37AmsAYExdCAIzV1XT94P74D2ZTBx5kCZ79BK+iw3SpjI6YiXrxDfjfeyJrZEGZ4nCI9mIG6KQaGW/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DBzD9mbhGQeqkWg4I7mbI1E58jgucOORdcXKyEajIE=;
 b=Pi8emrf2UMa4qnJRIlqGbGMJEdO6E5UtO+ujl/+/WSd2X0bSu3QljlV4glPV1rgo4torrR8MgQxSZR5KImDmPByM5a3jpNp5GqW+l+U9RG4+3IiEo8POPh4bUxDT5QGOAvxGolcsv7ZRsVzCHT5b149pgFRVglE0djknFJkUKvI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by SJ0PR21MB1965.namprd21.prod.outlook.com (2603:10b6:a03:2a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.2; Wed, 19 Jan
 2022 22:57:46 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%7]) with mapi id 15.20.4930.006; Wed, 19 Jan 2022
 22:57:46 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [Patch v3] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Thread-Topic: [Patch v3] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Thread-Index: AQHYDW8LZLmxPNQl+U2xqj6qXS4SXaxq9Msg
Date:   Wed, 19 Jan 2022 22:57:46 +0000
Message-ID: <MWHPR21MB15936397867E1F9FE78E899CD7599@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1642622346-22861-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1642622346-22861-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c49fcadf-10cc-45b2-bad2-5c677412a813;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-19T22:56:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f9e58c1-2b23-492b-505d-08d9db9f1bf0
x-ms-traffictypediagnostic: SJ0PR21MB1965:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SJ0PR21MB19650D54FEE5CB9E0EE45897D7599@SJ0PR21MB1965.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uaonnPKDIVBBu0iVlVcqUbc1y2MyFwWlGQiQsTB5lwtwOFvmLr9nlaIZels3P2IJnYBRjxxyVvqI5f8dyC9cII1kxwRHXbRsUGiNu5ge71JyrOifEyy941vticw2aiOdNMIlFi9WMLhfFvXS2g6u4oIWFY5vkWAnkFSXsvIkqCw/5GamE9t+pMUWodYA0rLnbrgtOp90HdPa7HDZAHcUrE1lbcZjdiFEmADPAJgpUQDqB8+OR+oLVonypyKvkMzqobMyxUcUkAOX1lP6cvr2foIJ4aKyNRxLGJUVaYwT4Gr+NHzYmiyNWax9cgqkk9vJXF+hYcu3GN5VFqHo2LCcu175t/p6Usa+Sb0CiaM7sG/UAoAQHomCwcGYEMm6/BjfHx37uPtGUxRFse68n0KQ3o8HZA2o70RFPRubhhFoqGxyZJLjLmEy2AU952w5X6EMgKCsAKkDz89MXWNIE8l1gMIoDXkSfJcZH4HwdpmZR82sQ8Wv+e8yHMZ/SXZ2PALa468nGHpoiw0MAEzvE7WguBCtnIGT7g9qulAvcVeKPs4TbI/rSdH+Qj5MHFzm7N+DGeqDjNA5Ru2IxuYD8noGftnwLIcQE3EzR0GObatgEUV/3V/EIH0MgmEbmvXadERGuk8WzaRPu1TuW0FJQWCy28OAmyPjAw7saRnbmh+KSmR+4/r53B/WdVv4Y4qlXWPSzidVuL42x0XipBjpkOXqIgqE798RQQlAx6V0EK1Uqj2hCYS2dnELaI44vEBRkW9u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(66476007)(66556008)(66446008)(66946007)(26005)(2906002)(64756008)(4326008)(6506007)(8936002)(8676002)(9686003)(8990500004)(33656002)(52536014)(107886003)(5660300002)(82960400001)(7696005)(186003)(82950400001)(38100700002)(38070700005)(122000001)(86362001)(316002)(10290500003)(508600001)(6636002)(76116006)(110136005)(71200400001)(83380400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zfjBgAnV16MVjXGl970vGxubygUvFS6c68mGRQI2DtUopZItjF4F9LUneNzN?=
 =?us-ascii?Q?A99T614oCaHZc8BVS+lBZ0ysMMuTxOCoWFeuK1piaatGRaCu5t+ludgirDJ0?=
 =?us-ascii?Q?714WZiCPK9OgtuuriLFrYH0Tr+VtE34kNw+dIx4h5rAJFUNypAocALDWT7F5?=
 =?us-ascii?Q?HbhQ/zDdACAXoXy5THr2ktFOJsgET1H71mCT14sbQ6MgXgRFguX49her8ZqC?=
 =?us-ascii?Q?lbO9H56nK0oYAAvS5awbwbqgQEXyzoGI3NOK2WMkFoKl8uWtg69GBu2YcY7M?=
 =?us-ascii?Q?hcgggiueZDKjsoqzUkg9RNcq9PzqLGwFjsL1+bSw+pS2U9UU+Ncky5HYR2zT?=
 =?us-ascii?Q?8puerfXlbpjj9RbHHqHAo+QMn+Dw5SMW6bZF4D9OgY5J9GQNukO6HnklvQ68?=
 =?us-ascii?Q?FInk8fmNnh7Qo7sSph5ebCYqMyPulLlK9VTZGwGHBg3/2UmoO1XO4bnDg2pi?=
 =?us-ascii?Q?ciqDqgEwEg+IUFeF1qFKCyJS0/sfxVlvrXrKCPJm61hpjwZWidIjOj8yFVtH?=
 =?us-ascii?Q?b3E8amz9r+fN6WaFLt9qkWBwACZNhNWjsGPp58KpTN93MXJAB0U5q71rpM+U?=
 =?us-ascii?Q?nl+iovGyTXIyfTDzbTiI5LAS0mBOh3y2C7QRSQS6pZKq2IE0JDU+w8b03Fx8?=
 =?us-ascii?Q?+DhFji+ZPnwU8i3ZJNWMIiMtNaoueD0jxN+NsgRsV41LQxQV4GyFyowxQcFP?=
 =?us-ascii?Q?DuwlyUB27q/WdVe++MCNSM8xJvUy7cvs4hEl19w3FDSJIQ9UdKO7Yom/R3vX?=
 =?us-ascii?Q?AepPy3SUW0Ndxx+2S7RHr4trhx8PEdQ0xwTtVR5aEHcgEFL9j94heQfSLYIa?=
 =?us-ascii?Q?slAqmghwZEITWEOLtXN9L0A0cf9eUSz1zQxI/Hd0L/MdOTODWZFiXppqIDDM?=
 =?us-ascii?Q?vUAAPc8Wk5nj/crXynw2d86MjN321MMqWC/P33Pd53L/2eyj53pY16A757Xf?=
 =?us-ascii?Q?WJlf8ozgqXAE7L79RIrKFJt2l2hDsZa0MGuGeA6DqAsyqBLHPW0hErd5nHA0?=
 =?us-ascii?Q?0Z0ojX546GhDj0lNCzrpyPssv2h5rqN3s0qUDCLjCL5/jnXJO3ZtGV2RyQkO?=
 =?us-ascii?Q?YbDeTr1F6Ww3Al6ohb7BDMbSH9NvHQ9eqEoVW/0/GB45IQ+y3C2eu8g5XaZB?=
 =?us-ascii?Q?I5C3ak2Ap2ZSX1CFJk0SbMTAQelu9mbCEkGpqQyBRnk7NhjCB2veGd5W924M?=
 =?us-ascii?Q?q9pJDrP0Lwy9eOn0MFdN/HhCzwd4Hrl4HlxfcX9OeIGjzaJ4hH6ciRsm1Won?=
 =?us-ascii?Q?FdUQf7MG+0gWo0yi2XXiNhUTPM27i5zTF/2b5qQdvbjQ5ncNwhdsrakUz9T2?=
 =?us-ascii?Q?bGxTlieZlWI7LOTGJcV/7UPBpP/pf2zAw1hzgn6hiol9wwJaEEoWIBa02usx?=
 =?us-ascii?Q?ojoeXj5T1gRorvKfLoZBl1iddsQXImeo2kAvwG4BJq2r8zu83iepI2Zk7onH?=
 =?us-ascii?Q?+O8kcJ0RfE9OrCZsfp/VHyMV7PtyMCIHmeM04sQRbuYlaN8iBm6NAQrlei9+?=
 =?us-ascii?Q?wf+QcyLwEIVpL9geCa1ROlp/+pcjKI91c1q9Df9yo3V6/WzK60hG0vSUAZtP?=
 =?us-ascii?Q?xVnj0kNQlFRFFUCCkkAaMVfa/NXsVaVagvstasw5aE5Qz8Czo2mBfeDKGgjF?=
 =?us-ascii?Q?qZNAHUYSROOOlKRvymxsmToBTZXwIo+im7evNheD4abB1H2vGAUYhQ2W49Eo?=
 =?us-ascii?Q?BvrjjA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9e58c1-2b23-492b-505d-08d9db9f1bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 22:57:46.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUm13DEpwQhsZTDkkYQnXVVYsZWGCrhuZvjW4FvE9/+IHmZkDVGV9vuG7B9Sk40HAE29N928RhHCKQIn2icuaA3YsYnegv6rhaWmBVXltF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1965
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Wednesday, =
January 19, 2022 11:59 AM
>=20
> When kernel boots with a NUMA topology with some NUMA nodes offline, the =
PCI
> driver should only set an online NUMA node on the device. This can happen
> during KDUMP where some NUMA nodes are not made online by the KDUMP kerne=
l.
>=20
> This patch also fixes the case where kernel is booting with "numa=3Doff".
>=20
> Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support P=
CI_BUS_RELATIONS2")
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
>=20
> Change log:
> v2: use numa_map_to_online_node() to assign a node to device (suggested b=
y
> Michael Kelly <mikelley@microsoft.com>)
>=20
> v3: add "Fixes" and check for num_possible_nodes()
> ---
>  drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 6c9efeefae1b..b5276e81bb44 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2129,8 +2129,17 @@ static void hv_pci_assign_numa_node(struct
> hv_pcibus_device *hbus)
>  		if (!hv_dev)
>  			continue;
>=20
> -		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> -			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
> +		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
> +		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
> +			/*
> +			 * The kernel may boot with some NUMA nodes offline
> +			 * (e.g. in a KDUMP kernel) or with NUMA disabled via
> +			 * "numa=3Doff". In those cases, adjust the host provided
> +			 * NUMA node to a valid NUMA node used by the kernel.
> +			 */
> +			set_dev_node(&dev->dev,
> +				     numa_map_to_online_node(
> +					     hv_dev->desc.virtual_numa_node));
>=20
>  		put_pcichild(hv_dev);
>  	}
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

