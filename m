Return-Path: <linux-hyperv+bounces-1001-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594727F3001
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 14:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFA9282BF6
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDE453815;
	Tue, 21 Nov 2023 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Am2iGR5p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386DA10CE;
	Tue, 21 Nov 2023 05:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJL6POMB36nEEyxRc8YDUolqphoeC654NHkXOVNHqdUcg8ac7y+QxRv7k49DHfNI2lPtzLBx9tLnxcX5RMFd1tEnz1NvBkTilj9L6o1pMr0toBXab24teY3EHoo5xuWOs5AKoG29WZ+SDoTCKXaZn+mCHvACVG0j2jihTfHQfFR77wk4V/q1sw1V9sHoKep8nyJmIL7dCyxx+nInSL+wsmAwfGODKsbDHUF3Oxz180XGB94BhTPF+CI59MxPT23OLw5Dvt/XL9OCtGmdJMuIO+VOi5EzLF+hw9/5O0/8L3I2zLdVkG2cJtGAjPMq5Hi31Y0hGLFLSUXC9RbMe1x3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4bTB+u3eDSCQvtmn7uJfgc5+8h5AvzIRR1arVwgLG8=;
 b=jbKKE3m9ecY7NF0l9sBAGteuc/sdSN3MhqKEPx82y6tQiA7dAFRlSlTtIA0rFIxS/X8h3uY9hcr8cghfFGk2nPkvUiWa9nj7KeOqAeAOyywnH43/ffWx7z7vvxym6l434nAIZEgZAUPNY2NwzcXL8LNevgSf6W1QyLWIzM6e8mky/Psxvi6OebSr26HVxIXBXJgevIOppxUm84sqST2ZkbToOz9vavmTDthRL/HhiY0gNS/1+2I1/7G6vyjixscXTYmKnbYlHti+MpUozKCTwGhgGk847cvY+GPJwUqNRIYVS4J8jyuFVFHGhhApWG3Q99D27a+PFAVG5A6Ftky2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4bTB+u3eDSCQvtmn7uJfgc5+8h5AvzIRR1arVwgLG8=;
 b=Am2iGR5pgJM12JYEQYGo9Sk0Puqx3lyFpBYSrmvDcKBnuEyU3x/eexatQFnLwwO702WWZhHylgKoGRybWSmLeRaaGFkB4yZ3dSqBnllWviYNIwMTmar9xKClE75fn2la8tpkfBPy9QQz+n4gJVG2QaMEapJ8rx5vbLLjDWHN4oc=
Received: from TY0P153MB0781.APCP153.PROD.OUTLOOK.COM (2603:1096:400:267::13)
 by PUZP153MB0726.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.9; Tue, 21 Nov
 2023 13:59:20 +0000
Received: from TY0P153MB0781.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd84:4aff:d0b7:1a7b]) by TY0P153MB0781.APCP153.PROD.OUTLOOK.COM
 ([fe80::cd84:4aff:d0b7:1a7b%6]) with mapi id 15.20.7046.009; Tue, 21 Nov 2023
 13:59:20 +0000
From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Topic: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Index: AQHaF8qGIm6eugOJi0KcyMy20QXRcrB8ayMAgAAObICACFwOgA==
Date: Tue, 21 Nov 2023 13:59:18 +0000
Message-ID:
 <TY0P153MB0781F6392EFB41FE2F50EEE0CCBBA@TY0P153MB0781.APCP153.PROD.OUTLOOK.COM>
References:
 <1700056125-29358-1-git-send-email-schakrabarti@linux.microsoft.com>
 <BN7PR02MB41487FDBD42B364683A5ACA6D4B0A@BN7PR02MB4148.namprd02.prod.outlook.com>
 <BN7PR02MB4148581D5DCF51BE46CC1B12D4B0A@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB4148581D5DCF51BE46CC1B12D4B0A@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0071c927-8068-4c89-9f7e-b0f11c93a890;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-21T13:57:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0P153MB0781:EE_|PUZP153MB0726:EE_
x-ms-office365-filtering-correlation-id: 2d4f5ae3-4e16-4598-0968-08dbea9a0e62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 q92nWXP2Pmwa5yGsQYtWLH3f44WGow4pa1Wu/dfGdE7A79LFV8x0ffMUksgG2Sb/Folr8f95GDoiX3yYbB1I2aj2f7vW/T/zBK1XG8LS5vazje1X+uPjxZYMpy5aB7NaW3OJYPaehJuhNxZOORQzh3xcnQ/V6AMh0yEVNqFA7U+eaRw8ZkL43aMjITjWWhFOG17enbHpGHmppBiZe8LevGAsyK9lPGAk/oEkTSqt6qc2n48vYIuUH/XqoVQxvxsyNsQQUPlsaBVJUt6LLQS5Zan3esZnQcxwW6M1jctuLANvSXSOlVankHwsPMgAyqICaGSR6dl2OLmSCgmDOi5/gao2mLwh8ZlfTkQ8KOomQbfyCxOj7yZ/LeXZEhuFDEO7eL4buclKSSv5oMzJrfqLoDwZXCufaGhq5G2j4iDiR2QzNgvQpZ+8SLxzjELqVa7S+CEzaFsi2Qku7Y64Mktr68rStH+CffPbuPZsuvK6dFBpeG4YktXNCqm5ZbDYM8EEk59yT2IT2yh/7mHvnj6Xik819Df30ZDxVJQOn2mkiClrwnx3e7iTL/FvuRn/ZrhHiuaRJEEN40QCfnKiKQvBRcqM0mj2GQMArBbgDYXdBJxjyONDxb1G9Dr0FauyGDPJ3v6mtSVbbfalPw7e1WOhmzANzo8JK9tt70MpzPma5SlFdLQOidKuN4lngjLf7FQk0MuA1gM2YOu0ouocPCi55mn5fytNYQpD6cILuBLxuFw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0P153MB0781.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6506007)(7696005)(9686003)(82950400001)(82960400001)(107886003)(26005)(478600001)(52536014)(86362001)(8936002)(41300700001)(8676002)(2906002)(33656002)(7416002)(8990500004)(5660300002)(30864003)(4326008)(66946007)(921008)(38070700009)(64756008)(66446008)(66476007)(66556008)(76116006)(110136005)(316002)(71200400001)(10290500003)(122000001)(55016003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LJByyA9KX0j4dMBpyIPYSk3/ElcXIk9AlEZoQlL3Jqj0BL5AatgcPwAHPcq3?=
 =?us-ascii?Q?CGn4twlZGxexw9ul2NbgwycrhPmCQjgbUgyZ7qRik3CkbY6YThWWcnvLby17?=
 =?us-ascii?Q?YOQyNlKGklZ7I3KiSc4MgD15xpoSUW8PEPj9zJ5FvKciA/UmrbWPy9JToRZx?=
 =?us-ascii?Q?g+8SELTgV2citPM955b1JtDXn3jd0cm1gzf21pIf/1wPoDb/8m5lUBTJ3vsA?=
 =?us-ascii?Q?nBVriMkGE23eFBQjwHaz9CPTqmWO4KLY1DmUu0BAosMzwLrRpKiSJljjV45t?=
 =?us-ascii?Q?8DYxxi23QYJ9unmQs8ueD7en3jswqc9KR8OmLy73CDQfA6fNGnSmVDU/EfPS?=
 =?us-ascii?Q?1Jifn8XrIBSOyiPBPm68fipzidoANLXwWrwf9rJCFMg5Dm3DilRhwV5AZxgY?=
 =?us-ascii?Q?xT6KfdEs6bpl1I7jFrMXZ1fREcJz1Hkacrej+RFFZxr2LY1BP0SBI7ikMiNo?=
 =?us-ascii?Q?q0B3699DcQ/YOLVqUtA+7h16W8FJQvK5o/MtOYDzXg7i2Bb1BxebfhOevjWh?=
 =?us-ascii?Q?fUT7PGtwwuaEvnUu+wKb4JyMH3mGqfP3+OvzxKmzI82DQpyrqqqVBsEV+wjZ?=
 =?us-ascii?Q?d64tCfA+cC/eb/4OWpUClGwxSRXfFcTqqGV6CBLzKMcXoiQqTVfRUnpmvfye?=
 =?us-ascii?Q?bvSN09dsDmVsMFS7h4sm9Kr3pnukg5yymQQsHBznKZShKs+QPY3wyIkqqzsK?=
 =?us-ascii?Q?W7EBe+ki9Eqo2cse+eZe0zO/qGYmqkz7YpQlteMsNre0H144Hm6Phse2o9UD?=
 =?us-ascii?Q?tpA6AbYXOa8FygDj2eJOqXaV+nuLRU9UDnVbhoP5hqtJYmuaq0EVb7Gwl534?=
 =?us-ascii?Q?iP9Dm5QRtuhgmExtXze2lljXcqBDb9TjSE8mYJjiIEoR34I0MMLVztFxj2D1?=
 =?us-ascii?Q?u7vsngDUy8tCFwc05w/Pb2jrubqaHR/lAs3VZwlD9c7W00EkIJRD3gAZEfqT?=
 =?us-ascii?Q?nEFhqXyof+RSNzMH6Ti+zDu/pWu8Aycuxv6ixaqPuINPn8Og/Wc5AxmZttMi?=
 =?us-ascii?Q?lujEjkIYSgvWh83gbv/zu8eMtHl3pRwWmQBcT3Z+YepzuW+WWMOmq8Cr4g4u?=
 =?us-ascii?Q?jBCZ05Zo5jvV2hj4xTUdyQjKOJYqXth3bUg7fRnz+/1yljjTKLiX1WZS7zhN?=
 =?us-ascii?Q?BZNO9xTNfekiz6w9BMuGj9UJShu2Ui30I/6gNrOTDje+lyMGttmqyYwJB6jd?=
 =?us-ascii?Q?dVTwcRuNR67Cdt0x7Q+PFGJmDinYX0OZPOtKPsbJAgeneOAhGG451ECQbizy?=
 =?us-ascii?Q?9u++YrrAHrlBp6eHV0MEcXdRuPBH5VowgYjGG9v1lZADGdx6A5r48AXK9rum?=
 =?us-ascii?Q?eVS8qNCYUy3mjClqrvw2Gnv8GBMygIYtM7g0Q8CzluSNAJC7rfM+Vxo/7Lf1?=
 =?us-ascii?Q?ICGA2Mly4kykQr+XNuj8ebdOj5T+noeQXHLWabrJQ8mgyheXuVMF9c2TXrRW?=
 =?us-ascii?Q?S6B9o32lRuKyXD+Pvyd+qKoirPq4MmEQBDEwl+XP1PY/QmZGwgheNLvlIcEL?=
 =?us-ascii?Q?24MGufWnlx0M3VYnNTJ7OGhPyDO41FoC7/GM?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY0P153MB0781.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4f5ae3-4e16-4598-0968-08dbea9a0e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 13:59:18.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdVP5nD9lGJTWNUWR+XxO5oCL639EJHeiXCQZNyZOySVEKSB0GJvmZqMItBbSkF7j5yA79J8a1FqEfRTEzy7TuNy0MTd2gbAvMkduiZaOUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZP153MB0726



>-----Original Message-----
>From: Michael Kelley <mhklinux@outlook.com>
>Sent: Thursday, November 16, 2023 11:47 AM
>To: Michael Kelley <mhklinux@outlook.com>; Souradeep Chakrabarti
><schakrabarti@linux.microsoft.com>; KY Srinivasan <kys@microsoft.com>;
>Haiyang Zhang <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>;
>leon@kernel.org; cai.huoqing@linux.dev; ssengar@linux.microsoft.com;
>vkuznets@redhat.com; tglx@linutronix.de; linux-hyperv@vger.kernel.org;
>netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>rdma@vger.kernel.org
>Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
><paulros@microsoft.com>
>Subject: [EXTERNAL] RE: [PATCH net-next] net: mana: Assigning IRQ affinity=
 on HT
>cores
>
>[Some people who received this message don't often get email from
>mhklinux@outlook.com. Learn why this is important at
>https://aka.ms/LearnAboutSenderIdentification ]
>
>From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, November 15,
>2023 9:26 PM
>> >
>> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> > index 6367de0c2c2e..839be819d46e 100644
>> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> > @@ -1243,13 +1243,115 @@ void mana_gd_free_res_map(struct
>> > gdma_resource *r)
>> >     r->size =3D 0;
>> >  }
>> >
>> > +static void cpu_mask_set(cpumask_var_t *filter_mask, cpumask_var_t
>> > **filter_mask_list)
>> > +{
>> > +   unsigned int core_count =3D 0, cpu;
>> > +   cpumask_var_t *filter_mask_list_tmp;
>> > +
>> > +   BUG_ON(!filter_mask || !filter_mask_list);
>>
>> This check seems superfluous. The function is invoked from only one
>> call site in the code below, and that site call site can easily ensure
>> that it doesn't pass a NULL value for either parameter.
Fixed it in V2 patch.
>>
>> > +   filter_mask_list_tmp =3D *filter_mask_list;
>> > +   cpumask_copy(*filter_mask, cpu_online_mask);
>> > +   /* for each core create a cpumask lookup table,
>> > +    * which stores all the corresponding siblings
>> > +    */
>> > +   for_each_cpu(cpu, *filter_mask) {
>> > +
>>       BUG_ON(!alloc_cpumask_var(&filter_mask_list_tmp[core_count],
>> GFP_KERNEL));
>>
>> Don't panic if a memory allocation fails.  Must back out, clean up,
>> and return an error.
>>
>> > +           cpumask_or(filter_mask_list_tmp[core_count],
>filter_mask_list_tmp[core_count],
>> > +                      topology_sibling_cpumask(cpu));
>>
>> alloc_cpumask_var() does not zero out the returned cpumask.  So the
>> cpumask_or() is operating on uninitialized garbage.  Use
>> zalloc_cpumask_var() to get a cpumask initialized to zero.
>>
>> But why is the cpumask_or() being done at all?  Couldn't this just be
>> a cpumask_copy()?  In that case, alloc_cpumask_var() is OK.
>>
>> > +           cpumask_andnot(*filter_mask, *filter_mask,
>topology_sibling_cpumask(cpu));
>> > +           core_count++;
>> > +   }
>> > +}
>> > +
>> > +static int irq_setup(int *irqs, int nvec) {
>> > +   cpumask_var_t filter_mask;
>> > +   cpumask_var_t *filter_mask_list;
>> > +   unsigned int cpu_first, cpu, irq_start, cores =3D 0;
>> > +   int i, core_count =3D 0, numa_node, cpu_count =3D 0, err =3D 0;
>> > +
>> > +   BUG_ON(!alloc_cpumask_var(&filter_mask, GFP_KERNEL));
>>
>> Again, don't panic if a memory allocation fails.  Must back out and
>> return an error.
>>
>> > +   cpus_read_lock();
>> > +   cpumask_copy(filter_mask, cpu_online_mask);
>>
>> For readability, I'd suggest adding a blank line before any of the
>> multi-line comments below.
>>
>> > +   /* count the number of cores
>> > +    */
>> > +   for_each_cpu(cpu, filter_mask) {
>> > +           cpumask_andnot(filter_mask, filter_mask,
>topology_sibling_cpumask(cpu));
>> > +           cores++;
>> > +   }
>> > +   filter_mask_list =3D kcalloc(cores, sizeof(cpumask_var_t), GFP_KER=
NEL);
>> > +   if (!filter_mask_list) {
>> > +           err =3D -ENOMEM;
>> > +           goto free_irq;
>
>One additional macro-level comment.  Creating and freeing the filter_mask_=
list is
>a real pain.  But it is needed to identify which CPUs in a core are availa=
ble to have
>an IRQ assigned to them.  So let me suggest a modified approach to meeting=
 that
>need.
>
>1) Count the number of cores just as before.
>
>2) Then instead of allocating filter_mask_list, allocate an array of integ=
ers, with one
>array entry per core.  Call the array core_id_list.
>Somewhat like the code in cpu_mask_set(), populate the array with the CPU
>number of the first CPU in each core.  The populating only needs to be don=
e once,
>so the code can be inline in irq_setup().
>It doesn't need to be in a helper function like cpu_mask_set().
>
>3) Allocate a single cpumask_var_t local variable that is initialized to a=
 copy of
>cpu_online_mask.  Call it avail_cpus.  This local variable indicates which=
 CPUs
>(across all cores) are available to have an IRQ assigned.
>
>4) At the beginning of the "for" loop over nvec, current code has:
>
>        cpu_first =3D cpumask_first(filter_mask_list[core_count]);
>
>Instead, do:
>
>        cpu_first =3D cpumask_first_and(&avail_cpus,
>                        topology_sibling_cpumask(core_id_list[core_count])=
);
>
>The above code effectively creates on-the-fly the cpumask previously store=
d in
>filter_mask_list, and finds the first CPU as before.
>
>5) When a CPU is assigned an IRQ, clear that CPU in avail_cpus, not in the
>filter_mask_list entry.
>
>6) When the NUMA node wraps around and current code calls cpu_mask_set(),
>instead reinitialize avail_cpus to cpu_online_mask like in my #3 above.
>
>In summary, with this approach filter_mask_list isn't needed at all.  The =
messiness
>of allocating and freeing an array of cpumask's goes away.  I haven't code=
d it, but I
>think the result will be simpler and less error prone.
>
Changed it in V2.
>Michael
>
>> > +   }
>> > +   /* if number of cpus are equal to max_queues per port, then
>> > +    * one extra interrupt for the hardware channel communication.
>> > +    */
>>
>> Note that higher level code may set nvec based on the # of online
>> CPUs, but until the cpus_read_lock is held, the # of online CPUs can
>> change. So nvec might have been determined when the # of CPUs was 8,
>> but 2 CPUs could go offline before the cpus_read_lock is obtained.  So
>> nvec could be bigger than just 1 more than num_online_cpus().  I'm not
>> sure how to handle the check below to special case the hardware
>> communication channel.  But realize that the main "for" loop below
>> could end up assigning multiple IRQs to the same CPU if nvec >
>> num_online_cpus().
>>
>> > +   if (nvec - 1 =3D=3D num_online_cpus()) {
>> > +           irq_start =3D 1;
>> > +           cpu_first =3D cpumask_first(cpu_online_mask);
>> > +           irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu_first));
>> > +   } else {
>> > +           irq_start =3D 0;
>> > +   }
>> > +   /* reset the core_count and num_node to 0.
>> > +    */
>> > +   core_count =3D 0;
>> > +   numa_node =3D 0;
>> > +   cpu_mask_set(&filter_mask, &filter_mask_list);
>>
>> FWIW, passing filter_mask as the first argument above was confusing to
>> me until I realized that the value of filter_mask doesn't matter --
>> it's just to use the memory allocated for filter_mask.  Maybe a
>> comment would help.  And ditto for the invocation of cpu_mask_set()
>> further down.
Fixed it in V2.
>>
>> > +   /* for each interrupt find the cpu of a particular
>> > +    * sibling set and if it belongs to the specific numa
>> > +    * then assign irq to it and clear the cpu bit from
>> > +    * the corresponding sibling list from filter_mask_list.
>> > +    * Increase the cpu_count for that node.
>> > +    * Once all cpus for a numa node is assigned, then
>> > +    * move to different numa node and continue the same.
>> > +    */
>> > +   for (i =3D irq_start; i < nvec; ) {
>> > +           cpu_first =3D cpumask_first(filter_mask_list[core_count]);
>> > +           if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) =3D=
=3D
>> > + numa_node) {
>>
>> Note that it's possible to have a NUMA node with zero online CPUs.
>> It could be a NUMA node that was originally a memory-only NUMA node
>> and never had any CPUs, or the NUMA node could have had CPUs, but they
>> were all later taken offline.  Such a NUMA node is still considered to
>> be online because it has memory, but it has no online CPUs.
>>
>> If this code ever sets "numa_node" to such a NUMA node, the "for" loop
>> will become an infinite loop because the "if"
>> statement above will never find a CPU that is assigned to "numa_node".
>>
>> > +                   irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu_=
first));
>> > +                   cpumask_clear_cpu(cpu_first, filter_mask_list[core=
_count]);
>> > +                   cpu_count =3D cpu_count + 1;
>> > +                   i =3D i + 1;
>> > +                   /* checking if all the cpus are used from the
>> > +                    * particular node.
>> > +                    */
>> > +                   if (cpu_count =3D=3D nr_cpus_node(numa_node)) {
>> > +                           numa_node =3D numa_node + 1;
>> > +                           if (numa_node =3D=3D num_online_nodes()) {
>> > +                                   cpu_mask_set(&filter_mask,
>> > + &filter_mask_list);
>>
>> The second and subsequent calls to cpu_mask_set() will leak any memory
>> previously allocated by alloc_cpumask_var() in cpu_mask_set().
>>
>> I agree with Haiyang's comment about starting with a NUMA node other
>> than NUMA node zero.  But if you do so, note that testing for
>> wrap-around at num_online_nodes() won't be equivalent to testing for
>> getting back to the starting NUMA node.
>> You really want to run cpu_mask_set() again only when you get back to
>> the starting NUMA node.
Fixed it in V2.
>>
>> > +                                   numa_node =3D 0;
>> > +                           }
>> > +                           cpu_count =3D 0;
>> > +                           core_count =3D 0;
>> > +                           continue;
>> > +                   }
>> > +           }
>> > +           if ((core_count + 1) % cores =3D=3D 0)
>> > +                   core_count =3D 0;
>> > +           else
>> > +                   core_count++;
>>
>> The if/else could be more compactly written as:
>>
>>               if (++core_count =3D=3D cores)
>>                       core_count =3D 0;
>>
>> > +   }
>> > +free_irq:
>> > +   cpus_read_unlock();
>> > +   if (filter_mask)
>>
>> This check for non-NULL filter_mask is incorrect and might not even
>> compile if CONFIG_CPUMASK_OFFSTACK=3Dn.  For testing purposes, you
>> should make sure to build and run with each
>> option:  with CONFIG_CPUMASK_OFFSTACK=3Dy and also
>> CONFIG_CPUMASK_OFFSTACK=3Dn.
Fixed it in V2.
>>
>> It's safe to just call free_cpumask_var() without the check.
>>
>> > +           free_cpumask_var(filter_mask);
>> > +   if (filter_mask_list) {
>> > +           for (core_count =3D 0; core_count < cores; core_count++)
>> > +                   free_cpumask_var(filter_mask_list[core_count]);
>> > +           kfree(filter_mask_list);
>> > +   }
>> > +   return err;
>> > +}

