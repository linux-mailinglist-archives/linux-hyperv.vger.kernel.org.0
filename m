Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07AF7252A8
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jun 2023 06:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbjFGEHJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Jun 2023 00:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbjFGEHE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Jun 2023 00:07:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A71993;
        Tue,  6 Jun 2023 21:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686110823; x=1717646823;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=11bkXIzpB3CEFdHHu7sADfmDwjZ/cWMivYFLM0pC2IY=;
  b=Aw6mHqAAjAz8u0s9AjwEKydNOchj3HLDNdWcajNKxHYM6Wbt3GKaMAbb
   ugC7rSjIofhUEQf8CEAcSLiYxK9wThsxhgYtGPAg8rRVgiq5jJB4E1HVI
   phWgduwx9E/JHNICNJcRtuGXQgL2YvuSazp2pGT/SGgARktlW5ZZPFYlS
   TtwO5+hV+19RUHpAaKg+uZCTeoXOQdF7hLtFJSOQqEuQY4BtHhw6ve5h9
   p211FEJt+7ermxA4YFFEWgimmCJr5ZXJYsQtFzj7Csd7USJ7ZfpR14Cl4
   g/3koIXC+FoGc0ExbEhmF4USOlwL2l3QD0t+QvlWXe5/sxqVbUvWUuWpB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="443241680"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="443241680"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 21:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="799128815"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="799128815"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2023 21:07:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 21:07:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 21:07:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 21:07:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFzTIsip/4LI1vn26FBsuNx8rCriA0r1jza1pOYnH54hxs2HfBAS578dhe84rAbCdPxfukFYzWwKTxTa4Sjf+DMlQ0ZOvHGO44IiTFfFwMyVGJPPdopt0UkCEzM3aPLaxGLzmpXC/fQI/SMqDToFJ2PK30LvNsqc6o10/sR3/npcCTgwM7zOYWbsReOC0AHFDTaupkqiQQHLMbzorc/oAvOKcCokvLzZkZ/zpu+9ONgZR0ncvC+oeqbGx/1Y0VNi6Jcn/YZfZObzypp0kv09XLhul4OfEU+qLIEFNJCR3srkFolEutVyy6xzsy7npHS7T+3j8iItGEarKH+D1zlxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQY6cjNYtiP7GnmtPKSLX62QFJH+M1Rujd0E+Pjozyc=;
 b=AtnTSpan6AdTPA8DBAuARwTILo1X/rgK9APRQ1TdpZrPNaPqYia2TnvOObpDIOk86ud3eBr3Vo84vDk/qpPRKn79fD3wd0aXCD8dZlyrNLe+OxPoRw6v52b7bHdGZRNEpRHkWmFBBA1eTxERaHNZumYXmTnVMVCmxtGvSiYGpK9bHjpCOLPJXyu94dSLmtbdVe/u7yD74zb4EK984v3P6aRsRsjKUTprSOn0kGgaeM85Vm3HyNXTjQAPSRHzjetfi372CHKTojgVKAP9j+EwWZhG2wJnoS87AlDwJFaWLj6Ox6H1ex0L+Hvhf+un2c+y++642Zfhk2s4qm21RjBSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB4909.namprd11.prod.outlook.com (2603:10b6:a03:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 04:06:54 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 04:06:53 +0000
Date:   Wed, 7 Jun 2023 12:06:36 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] sched/fair: Fix SMT balance dependency on CPU
 numbering
Message-ID: <ZIACTGpTD7FLfd1K@chenyu5-mobl2.ccr.corp.intel.com>
References: <1685555673-2363-1-git-send-email-mikelley@microsoft.com>
 <CAKfTPtAyFqG4W0OAc6pejKdEQ4yTRaoC+qiOZN8sRrwCENmVKA@mail.gmail.com>
 <BYAPR21MB1688C7D7309FEC2B01529C0FD752A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAKfTPtAeA1SxLD7VQ0sVc2G0AAKrNs9ZxoZPj2uR8x5DZQiomQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtAeA1SxLD7VQ0sVc2G0AAKrNs9ZxoZPj2uR8x5DZQiomQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b1745b-10c7-4d3b-052b-08db670c9f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcxAnwOsMQHfzGYIp0CYO6n3o0UTagFFSgnH+1j58tnfbmuIoeUdozNzhffcRiPu95jaObH3SJPbb6PhC6p+W2bCXiDEHGr+QeVTG4TsTTPDPgJ2rosEio5BkOM75axPk3VBm0c769geRoet0eQfQLdSu0SZ9jk7grRLQZzZPQ5KzCZrfJkGhtQJZijj9qImtccw0S58fzR8U6/g9YI2hW2BdktfdVKzZArAoBH+t1Z4Tf+10m69L1WuzpiqeWkhTicpTYlewDFz2lK8YbGDzIdsR7XcQjXQxiGZ4tpb1GOsNszWWbNYUu3u7Uk5xHG3CJHF5W1rMQ2/972i8tQz2Zx5wGrEW5THzomIm5iYYpcN6y/TEy5BghDOPb6qXxGb8hUQrLN/taTnj630IPTm80lH0AAvXSEaRAzWuoXlEhnQ1jeMEBcCTWEyCObBX+1DO5X3XUZYjpQ/cMzuUj/FvWqsJCvxbxUyr/OYmce3UYbmmGVoY166AHpI+LTI+BvJydolFqhAYH42sEnzbxOCP6Oy1d8+MflNk8xuHrEtdQOR6XeCn7rE5C9Zn4hk2IRq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(6512007)(53546011)(26005)(66946007)(6506007)(83380400001)(4326008)(66476007)(6916009)(66556008)(6486002)(6666004)(186003)(316002)(478600001)(54906003)(2906002)(5660300002)(8936002)(8676002)(82960400001)(86362001)(45080400002)(41300700001)(7416002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDUX6YJCHU5zD98LknAa4+rwcaf+VvCc4FXPYWy/s2dfNDH39WGtRs2AsoHm?=
 =?us-ascii?Q?9GneQVa8ksazO+FTEpEYIHehY8wMlCSfrNZq4vuB9Gbwl0N0zhPvI/wlhozE?=
 =?us-ascii?Q?KGS+nJaUxpME79LhOIp1ajK6sRdfacguEcASZ1CflQhJGD1BE2CN6dXJEvjc?=
 =?us-ascii?Q?ZBnIrGhtZfzimSz4OTT3sB8jHowUxPJ7f4ZfV+XUe5qoq33iHxf9Z7xq6rGe?=
 =?us-ascii?Q?els7CgJxmz7HH1MyIpnAsD5Y/27Ol6psBzvzm1QX7HyvRW43WwW6s/XKT8LK?=
 =?us-ascii?Q?cvEIRxkZDlyweh13zPTgQLLHMTHNj6H6my7M9gIyH5Qqw1s53nr7ipC6WQ0M?=
 =?us-ascii?Q?/3NdYLOtn5Wx+aJojJGlzNTK/hcX6ujxVoOLUIN57AjW1QbrdgmmW7Mx3/a6?=
 =?us-ascii?Q?DRrMoJgxzGhBEObANVj8nRnqExcSQAj+l+BNHT5ntqzCU7iKdcYj1ZOTM8Mm?=
 =?us-ascii?Q?M61scxt9ZWYMGXWlKlBW8+/xtmn54PtMpON5H79UztSSc7NUuM70b8cAISFr?=
 =?us-ascii?Q?EQqXEQhChQ5+Y3DtyM1bCDE6HfCVzV2BqADgpSimQqyPAG9AtnUUR0yiPMxv?=
 =?us-ascii?Q?g9iWK6QLo9Fy9ZyGtCxJh6SAHofUIeckl4hTlxHOGTql2BdwzajXTNbELhz2?=
 =?us-ascii?Q?CJ8p+Q1hdjWojLirtU01vwy0fpr9mnoy9yS77J+/W/aDfc35Dxa6munfj5LV?=
 =?us-ascii?Q?scle8sELgaHWNA3Is6uYc7WiPpU6/We8pZadhNvSVQuqRxXbU4uQfqX2H1BB?=
 =?us-ascii?Q?o5+51rWMuDpZW4tzJ2989w4x1ijQ0cAFQQ7n4qm5plw6SbPA1y99o0tAxgHK?=
 =?us-ascii?Q?UxDotglcFE1pYx96gW5yrs/Kdk25TlQroVtA+l3j6EJ9wx90d2P0OK/G2XtM?=
 =?us-ascii?Q?357s+WX2+8jBCK/cXxpWVihEULRXyL3Ewaw+OfJxxMRtu//jRRTUJDajzU6T?=
 =?us-ascii?Q?habTufPTRHbYoaiqxPXb7SeXINtBi9UylTy6cMP36ipCPSDa1uae4QEh1qHK?=
 =?us-ascii?Q?K+OCfyLGU9PfutNfyAxu6emDWRUkmHQ7NVjVFBS2LFYZtC5vu4EoQivG6T1b?=
 =?us-ascii?Q?5Hx/cLRmD9HnsfJpPZY6UKpTC1IFfee1e3Yv/XxxZCPmC01KzJ6EMDYM+c+4?=
 =?us-ascii?Q?rAfurBHjluQmd6PQhu+2MpIpyZEzLailFxs9p05php+rare3t823AoBl0x+E?=
 =?us-ascii?Q?NMk4xO1FWHpgYMbB2+RjcAhKsmKINNRsIl+SDs34jeUAewjc7+QS1UWgTswQ?=
 =?us-ascii?Q?c8nC709pr5sg5D+c/jEU42aHz6A3bixn4aiEpi51i+qllEmroj0gU+iPSUCh?=
 =?us-ascii?Q?eXvnJaPwt8ZVmjWwIAqKoENXLfYcH29+f4QXWLJpR5z8Mqbp1srdrAQfiO5M?=
 =?us-ascii?Q?2Ra3pfo3Uhmq0vf/Psq8BoAc9a5K/53K9hG1XDwHpHoI++2udbdvptex4hAP?=
 =?us-ascii?Q?5A5dCWZTXyZE3/WRSW5LTvvyHCiwQe4GoXM6g7mXgiO0TJY3IbNkYhDc9wy5?=
 =?us-ascii?Q?QHu/KTbIGJfLPCOnzM1Q9cJWdGYdzPbFvk7gVG3mgMWww8A4AOgV/gXLANI3?=
 =?us-ascii?Q?jZmhRRTpybQSL4Gta1T6atvEtgnT+R+LS+HYeWZi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b1745b-10c7-4d3b-052b-08db670c9f83
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 04:06:52.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGN8kPr70upmZOSGhy5ZdDuZCLHNmxzAFwr405QFjMlk/odeppzp0BGiMyJk3EZCFVDhcT2X0exqjzoKxOblJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4909
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2023-06-06 at 17:38:28 +0200, Vincent Guittot wrote:
> On Tue, 6 Jun 2023 at 16:08, Michael Kelley (LINUX)
> <mikelley@microsoft.com> wrote:
> >
> > From: Vincent Guittot <vincent.guittot@linaro.org> Sent: Monday, June 5, 2023 2:31 AM
> > >
> > > Hi Michael,
> > >
> > > On Wed, 31 May 2023 at 19:55, Michael Kelley <mikelley@microsoft.com> wrote:
> > > >
> > > > With some CPU numbering schemes, the function select_idle_cpu() currently
> > > > has a subtle bias to return the first hyper-thread in a core. As a result
> > > > work is not evenly balanced across hyper-threads in a core. The difference
> > > > is often as much as 15 to 20 percentage points -- i.e., the first
> > > > hyper-thread might run at 45% load while the second hyper-thread runs at
> > > > only 30% load or less.
> > > >
> > > > Two likely CPU numbering schemes make sense with today's typical case
> > > > of two hyper-threads per core:
> > > >
> > > > A. Enumerate all the first hyper-theads in a core, then all the second
> > > >    hyper-threads in a core.  If a system has 8 cores with 16 hyper-threads,
> > > >    CPUs #0 and #8 are in the same core, as are CPUs #1 and #9, etc.
> > > >
> > > > B. Enumerate all hyper-threads in a core, then all hyper-threads in the
> > > >    next core, etc.  Again with 8 cores and 16 hyper-threads, CPUs #0 and
> > > >    #1 are in the same core, as are CPUs #2 and #3, etc.
> > > >
> > > > Scheme A is used in most ACPI bare metal systems and in VMs running on
> > > > KVM.  The enumeration order is determined by the order of the processor
> > > > entries in the ACPI MADT, and the ACPI spec *recommends* that the MADT
> > > > be set up for scheme A.
> > > >
> > > > However, for reasons that pre-date the ACPI recommendation, Hyper-V
> > > > guests have an ACPI MADT that is set up for scheme B.  When using scheme B,
> > > > the subtle bias is evident in select_idle_cpu().  While having Hyper-V
> > > > conform to the ACPI spec recommendation would solve the Hyper-V problem,
> > > > it is also desirable for the fair scheduler code to be independent of the
> > > > CPU numbering scheme.  ACPI is not always the firmware configuration
> > > > mechanism, and CPU numbering schemes might vary more in architectures
> > > > other than x86/x64.
> > > >
> > > > The bias occurs with scheme B when "has_idle_cpu" is true and
> > >
> > > I assume that you mean has_idle_core as I can't find has_idle_cpu in the code
> >
> > Yes.  You are right.
> >
> > >
> > > > select_idle_core() is called in the for_each_cpu_wrap() loop. Regardless
> > > > of where the loop starts, it will almost immediately encountered a CPU
> > > > that is the first hyper-thread in a core. If that core is idle, the CPU
> > > > number of that first hyper-thread is returned. If that core is not idle,
> > > > both hyper-threads are removed from the cpus mask, and the loop iterates
> > > > to choose another CPU that is the first hyper-thread in a core.  As a
> > > > result, select_idle_core() almost always returns the first hyper-thread
> > > > in a core.
> > > >
> > > > The bias does not occur with scheme A because half of the CPU numbering
> > > > space is a series of CPUs that are the second hyper-thread in all the
> > > > cores. Assuming that the "target" CPU is evenly distributed throughout
> > > > the CPU numbering space, there's a 50/50 chance of starting in the portion
> > > > of the CPU numbering space that is all second hyper-threads.  If
> > > > select_idle_core() finds a idle core, it will likely return a CPU that
> > > > is the second hyper-thread in the core.  On average over the time,
> > > > both the first and second hyper-thread are equally likely to be
> > > > returned.
> > > >
> > > > Fix this bias by determining which hyper-thread in a core the "target"
> > > > CPU is -- i.e., the "smt index" of that CPU.  Then when select_idle_core()
> > > > finds an idle core, it returns the CPU in the core that has the same
> > > > smt index. If that CPU is not valid to be chosen, just return the CPU
> > > > that was passed into select_idle_core() and don't worry about bias.
> > > >
> > > > With scheme B, this fix solves the bias problem by making the chosen
> > > > CPU be roughly equally likely to either hyper-thread.  With scheme A
> > > > there's no real effect as the chosen CPU was already equally likely
> > > > to be either hyper-thread, and still is.
> > > >
> > > > The imbalance in hyper-thread loading was originally observed in a
> > > > customer workload, and then reproduced with a synthetic workload.
> > > > The change has been tested with the synthetic workload in a Hyper-V VM
> > > > running the normal scheme B CPU numbering, and then with the MADT
> > > > replaced with a scheme A version using Linux's ability to override
> > > > ACPI tables. The testing showed no change hyper-thread loading
> > > > balance with the scheme A CPU numbering, but the imbalance is
> > > > corrected if the CPU numbering is scheme B.
> > >
> > > You failed to explain why it's important to evenly select 1st or 2nd
> > > hyper-threads on the system.  I don't see any performance figures.
> > > What would be the benefit ?
> >
> > As I noted below, it's not completely clear to me whether this is a
> > problem.  I don't have a specific workload where overall runtime is
> > longer due to the SMT level imbalance.  I'm not a scheduler expert,
> > and wanted input from those who are.  Linux generally does a good
> > job of balancing load, and given the code in fair.c that is devoted to
> > balancing, I inferred at least some importance.  But maybe balancing
> > is more important for the higher-level domains, and less so for the
> > SMT domain.
> 
> As long as the hyper-threads on a core are the same, I don't see any
> need to add more code and complexity to evenly balance the number of
> time that we select each CPU of the same core when the whole core is
> idle.
>
In theory if a core is idle, either the 1st hyper thread or the 2nd hyper
thread is ok to run the wakee. Would there be a race condition between the
check of has_idle_core + idle core checking in select_idle_cpu() and the
task enqueue?  If the 2 hyper threads within 1 core are falling asleep
and wake up quickly, we have a false positive of has_idle_core, and
incorrectly think coreX is idle, and queue too many tasks on the first hyper
thread on coreX in B scheme, although coreX is not idle.

thanks,
Chenyu 
