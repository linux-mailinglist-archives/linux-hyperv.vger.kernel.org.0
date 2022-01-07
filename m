Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA74879C4
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Jan 2022 16:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348112AbiAGPeT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Jan 2022 10:34:19 -0500
Received: from mail-centralusazon11021022.outbound.protection.outlook.com ([52.101.62.22]:14010
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239606AbiAGPeT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Jan 2022 10:34:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh3Bl12mtlXSSZtFbKGMxlpkHv6tapS+RJ+xJ1YQt0dLvFEyV+ZWYeTG8rY2y03SP8iUl4qxWIuTwFrBj0qQfIIrdR6Rmu5MVB/1y8WIimeQim7Cx7fz5PdBAAmV/h86W6QoBu5Hi7k1VfD+ei2O4OuKO8w+dtmzsz/DQTIjVMTYZSdpo7gtkwl5Sm0zvrL7xnart2JuwjOS9WRVYE4l/f4VVMUuRfNJiHx8PH2WRHAyuNNnNY4iziZvOsFW6On75CmJrM1tAbFJiBPsJZ2Tum7ToPHhLaUM3uaL1rer2h+m4DVzOPD5LbBYaN7MSqUQ5BxmCWb05NFYZR/Z+1TyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyKQzXbv9D9Znq/Qk0nLMIU8Ivh9aH0TRKupfklLHjs=;
 b=WClLDmGdNmFeYfOFSJfCVVq8PdSVkYm1P50xu/+69jAHUPxK90SIdKniHtGcxvcBRhHcUXiLQA5VhAE56FK1Wh24YkdgU+fR8Vbu+BGif2wsFReemJVY9aTdiItz3gcJO6huXT0HRg/bv4/zRIyM4Rnt+7u908BOvzh3bv+2BSJFid5paNvHDLvSVNAEsj9hpQdOwGplwY18ndgTm8R8sA1WXjbcvAkA1eu9/Aq5LZK5/zzKEN2jEcIw6/j+EP3G1uROS/9lwK4oMRUc53w3sfPN3dvqk+D5uHWpyh7tbL/4Iw9shUSY6fF2B+51YrPhmYVjBIBF5XpLovcNslS0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyKQzXbv9D9Znq/Qk0nLMIU8Ivh9aH0TRKupfklLHjs=;
 b=CUl0qP4GEHKaGPDJfJrWcqkxztLx5dAyAC5vn9qwHY9Udu03NCOd1NZ8rHZZOb6otfRRv9CuyfTNwZ/cL7P2XxUweazWbkwCPm/LqFEF1v5YODP+byjRVToJ+i7p8nqREcyH+tgUQkNIyB4kQGh1r4bpZ4pVuLhK8KaoR/0K5HA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by BN6PR21MB2093.namprd21.prod.outlook.com (2603:10b6:404:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.7; Fri, 7 Jan
 2022 15:34:16 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d%7]) with mapi id 15.20.4888.007; Fri, 7 Jan 2022
 15:34:15 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Purna Pavan Chandra Aekkaladevi <paekkaladevi@microsoft.com>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots with
 parameters affecting NUMA topology
Thread-Topic: [PATCH] PCI: hv: Fix NUMA node assignment when kernel boots with
 parameters affecting NUMA topology
Thread-Index: AQHYA1QWURfWxy//0UuSygYpK/bNEqxXrRcQ
Date:   Fri, 7 Jan 2022 15:34:15 +0000
Message-ID: <MWHPR21MB15937B050A3E849A76384EA8D74D9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1641511228-12415-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bda7ebd-c08f-425e-b37c-6b8fc48aeffa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-07T15:18:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44afb976-7088-4162-02d2-08d9d1f329d1
x-ms-traffictypediagnostic: BN6PR21MB2093:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BN6PR21MB209314B145BCECF17CD57BA9D74D9@BN6PR21MB2093.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uMMeoisryALdJRqjOo8nC4DDUnet29UqGXVxhkuxyBK2D7GtyHjAjtNJ3tOWZZQxHDmUrjBKcTnuz2GFEVEj29eHKQTVLerO8+zcCmCHiRs952jIH3GgxXHPFGXN9H6jtyY0s56o392eGGHNC6xgw2U4tqGd8+TNaZ0s/UL0fT7M/FEXNGpvbIPukT4ciaRIdogrL1iDmuLkK3Xj1BdxsctGOGUHlu6wA8D8sjoO8v7ud00PyNxyE7YHJfaw4YklDHdMAfrx1Iaz0Uj/j/PiEqEBpsJMZO5fIdZSvljJANvFKCpOuxqzKpDz3HJ1hhXLkcMbMEnLEZG2FI6pI9cCQUTDP2X6GcUxLtmB86q6TxVpXN1e2JBKq/Wh1HCo8OXm0wW1wKcUintF8D1D3i953G1/ENPRksy1hIH/aEgfvYOQ+JNOwvgVmnxNSrPGivPBJat0+Ddvrf7dix4nBi2dRTAriDtbrLSDSCrZq6v6sfHZCd0ZZ6ORNqu3OAbWhHmdVyNqDbmewR3+3aB7gUaBK/3/wzxe+2lagE4m/FhLhxcKe726ft4VeSCNuEn9MiKG1Z/WHAiT+X2c6i1Xp/YEwBx/0Xwe6yWyHwoQOYpN0FX3TsksE8v1nyccmH0KZlTjM25APRLFvFmU9HoMfnhmhQ3wIBQ0bO7LbuWq1ONu76AI8xQPO278PkoE0THp5tuc8jClW5oRNe5ov2kezoRN50omZutqw/Ai8qQQY4o5kPnhdp/bFyos1pHOgZqjKTHi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(508600001)(5660300002)(2906002)(10290500003)(76116006)(71200400001)(316002)(82950400001)(110136005)(38100700002)(82960400001)(6636002)(33656002)(8990500004)(122000001)(55016003)(107886003)(186003)(26005)(66946007)(4326008)(8936002)(66476007)(8676002)(52536014)(66556008)(66446008)(64756008)(83380400001)(86362001)(9686003)(38070700005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3f+coKqsF5BR99CbbiUn8BBqlDrhPpyrXPEcDo7uSFa1fLkwEu8gMUd7edma?=
 =?us-ascii?Q?e/9x9u6/M66rhTaQMYb4kIiwJYPKTUdYgzHUP3Mzz9KQOzmAChBpDjJf0n8W?=
 =?us-ascii?Q?seLuzF/0N3OkpuugJxqE0Xs1SBZ8sXYwiRCpTzcGmamizYIsAJQzbSK+y3rK?=
 =?us-ascii?Q?OLpalnuSQujOJw7EY6U2X0QaInEVN7O3GoqXeF+IxwzxSyacxmzHFtLt9HPF?=
 =?us-ascii?Q?VvAsFYZqKP5jE+vMIb26DLIug00wXf3ItM4mWXNfwmXy5ANyDm0jjVNUNTXQ?=
 =?us-ascii?Q?r4vrnkp01bGTD3QQ3Ih0uFsnBsk9trCJlXfwd5Op0PLT1nOUlX+3bv2TqWcD?=
 =?us-ascii?Q?gMWMJ1XPNLhFOOFBmrVCnl4S5H4wr3gLsdXx9GiDpA15MiDbhzaxrTaM9bpl?=
 =?us-ascii?Q?5Is/rDUUAJK2b1nUb7jMhUckqkFcQhlzLaNuGytyMWjohDQ0pHdLjlrqz4KL?=
 =?us-ascii?Q?EMUMbnUxgnPE0DTpoMhU8rJSbG4ilMUxL7qWhuJ3QitYOZJJWr4rlF+cD9/7?=
 =?us-ascii?Q?xb1fYdkNl62o0iua8qWot6333vMUl2780m8pCMNUWVj/xuGDLk6CFJC8s2eq?=
 =?us-ascii?Q?Dq83uZAOknO4hMsAT8jRwkRAm0NoW2WSKdf9K0sgcFgdIvfLDFXfoZgo9mMr?=
 =?us-ascii?Q?l1u6P7j4dpAfE1iP8QO7DLF8Quswl4+w7xvAhrZqZr5u2cDCJKuBWIv6wZq3?=
 =?us-ascii?Q?9jb6v1c8/JmlWxJVGGtslxx+YI12e829521HQiIm6Zk8lV68/FevHeDgC7QV?=
 =?us-ascii?Q?TYgAkvPt82CMzheWjNF59O2eWVPq+hA6iTIGA87Cp2QKup4DD+U83QUbaL5I?=
 =?us-ascii?Q?jXOSKvJOsUCh1EOQm+B/GRwzjBq387HU5TEwF3UWkjq2fkRrFNIGb3JFrEx5?=
 =?us-ascii?Q?nIaN4EbJznFEDiepX0JZTBtIrJjbRUOK4FdtgEtW1xknojeUhlaTiVj+vQ+q?=
 =?us-ascii?Q?h8kM2nvl488FLVOhWdeJJqiLa7Swmgyaills+OanTecWoQDuf01s8TqCEEwd?=
 =?us-ascii?Q?dBTXg3ZutRS/JLTAO/CZjdUea69tMKsWRWw5eTpiKDdNGtaxGhFd2bATtljW?=
 =?us-ascii?Q?4MKwK/Tp3TIgSdmnv3813sNKp8DM4Y34me+FGmIq4a/eKmkgSQilG8KJpzjq?=
 =?us-ascii?Q?3ZopzZlqnUveZd6dWfwmcvXoRYpJiYPqcZZi92d+6cR+Tdm2uJwX1y58D2+w?=
 =?us-ascii?Q?IcKDgt6Z1nWsUqWMlL1EnXjNcYZ2fnYo32l53mzdr3KTloCIDSP5gqQzVn7i?=
 =?us-ascii?Q?CBeAka/uPc6GNXpzFel01caWff//ryELhGm4aoyvt0wP5/7Ehxc8UuYGifIC?=
 =?us-ascii?Q?S37uSj/pFNlXnZfqC/4uqTUnG92gPFSAZKlXaFTocuENBAGVOeiU0i/pjSTH?=
 =?us-ascii?Q?mUULgShBsUFi17/qb3etT3bs8xskn/6buG1eCSqeyQQY8KJAFak/e7cJOklw?=
 =?us-ascii?Q?+IIsWbyhgosIfb4m5P1rGKrUZOZDscHXSHq998vwxukEuGlgwgSmVMMgfPRN?=
 =?us-ascii?Q?RiE3mZoz1OdxQbeEGPwzUUf5Jv+qWR3S4E8T0X6ry8QVakP5E6BN4IVTmfl9?=
 =?us-ascii?Q?8bfUOCHP6rbP1aHat4BBl1RTBj6x2IV/a2k7azNKmcOmbeufdDWZVAb1H/Y8?=
 =?us-ascii?Q?+AOzpZl6d2xYXKT9zCrFfANsLkIQ/3lu4j2y2eMa52ATRQnnNJ/OW2oxwnne?=
 =?us-ascii?Q?/GI80Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44afb976-7088-4162-02d2-08d9d1f329d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 15:34:15.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXlGIEb4T8H4LEuK80IzcH68NRNuWk6U+gGdbcbb3bEtOOPiGckSOzDhHf6Mn4xG1Se91nm5WnoKwfNoS/j9xiEKyRyMbuNw9cIEnBhfImk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB2093
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Thursday, J=
anuary 6, 2022 3:20 PM
>=20
> When the kernel boots with parameters restricting the number of cpus or N=
UMA
> nodes, e.g. maxcpus=3DX or numa=3Doff, the vPCI driver should only set to=
 the NUMA
> node to a value that is valid in the current running kernel.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-
> hyperv.c
> index fc1a29acadbb..8686343eff4c 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1835,8 +1835,21 @@ static void hv_pci_assign_numa_node(struct
> hv_pcibus_device *hbus)
>  		if (!hv_dev)
>  			continue;
>=20
> -		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> -			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
> +		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY) {
> +			int cpu;
> +			bool found_node =3D false;
> +
> +			for_each_possible_cpu(cpu)
> +				if (cpu_to_node(cpu) =3D=3D
> +				    hv_dev->desc.virtual_numa_node) {
> +					found_node =3D true;
> +					break;
> +				}
> +
> +			if (found_node)
> +				set_dev_node(&dev->dev,
> +					     hv_dev->desc.virtual_numa_node);
> +		}

I'm wondering about this approach vs. just comparing against nr_node_ids.
Comparing against nr_node_ids would handle the case of numa=3Doff on the
kernel boot line, or a kernel built with CONFIG_NUMA=3Dn, or the use of
numa=3Dfake.  Your approach is also affected by which CPUs are online,
since cpu_to_node() references percpu data.  It would seem to produce
more variable results since CPUs can go online and offline while the VM
is running.  If a network VF device was removed and re-added, the results
of your algorithm could be different for the re-add, depending on which
CPUs were online at the time.

My impression (which may be incorrect) is that the device numa_node
is primarily to allow the driver to allocate memory from the closest
NUMA node, and such memory allocations don't really need to be
affected by which CPUs are online.

Thoughts?

>=20
>  		put_pcichild(hv_dev);
>  	}
> --
> 2.25.1

