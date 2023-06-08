Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5935E72751D
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Jun 2023 04:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjFHCpF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Jun 2023 22:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFHCpC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Jun 2023 22:45:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FC42103;
        Wed,  7 Jun 2023 19:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686192301; x=1717728301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xF+FClIpfpdWQDH2KrRs6tezYDl9qvgq7p6eWdZMW/0=;
  b=gW4r6yE1aYpmizwFc6f2iSsFmVkgeOPIaOVZbhR/EEjGVXM2YGlSSHEd
   3M/OzcMnHDiygDJct1E1cdCTZlgIUSDGOA0MKlVigLvZSBueII+uJ6I4l
   AGtprFb6OHXMdYzt+i8ITh6Uh396TsHUBr940SWaeC37W5FMpZ56yed1c
   4QJFQYzxh5MvcbS3dG3GIbR2Cj9fdbBe3xf917SCXx6zqTfBVy/Rtwo7g
   YAq6xPJ8+rV58I+K8OrKqC+S83lKMxQ3tQtGJCc7pGuxFCU+AVU2WqvbH
   EiUMyN4a1BM44WuoxCC3TQ8dRIBXNYawCVJX85YbXR2k59aSx9f4F/Meu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423026948"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="423026948"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 19:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="712930029"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="712930029"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2023 19:45:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 19:44:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 19:44:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 19:44:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 19:44:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1lqXSTh9/ye4Z3j1GgJFdKzsi3zDPqh3boX3WvWKsC/k2GTC2J5cA1ipUVsCQy1UjsmxohwCRxq5jUheZGBUwClViB4VbDTE8FyU17TqxAmKtDPccbCdv1Mkadf6+eZLlsx2a1jTdGaas7FhvaWQLFsXjBKLDIq+LnwWpWF2Dctahr0zkSiko+OsLkHF8suYQ3huawct6Es+yeCDAPoNx3kGqdPkRFw077dwoa3gVl0Y3Z2ymQN8nN0OHmRyReCIleX61fU1LWZnSSEC/K8L5NuBH5rdzZMCvyGkbxyonCzbhYRnsVtIWxIZgjxVs5o5W09saO1yBauc+esAQ4how==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQKJAVtoYKlBDx9SpYRPChVuQtaoFIGw444Ex9R1Bsc=;
 b=Lr9ppsNZ6ORLJ5D5POiRrN08BLDoZeW+hTL3t4ZP2AuS3cxhzzDu/gExzeV6ur459Ua5Rv1Fi/5DYvdBLQWl1eHgvKI/hzu0WkjYeazocPX2khi79Gk033jgKcScSLuq/Js99uHLXjNZI6+Q0oaSLp1WWDyHIUriBCO8xabaRPq+1IjEAsaTRT+NPFFNuNTIijOeaCkTw5cPSMQ4bAJR9EtEpo++OPFG/QJwNmgILhIblcOzgWo91uiq0q0yUh31pAhc9JrttiDZo8Kz8/YlqA5Mdf/nGJOAUXxXSspCaf2g3lAiYoE5KZB5rOPUTa5GiUYJcfNyRhbDEvC8ooiWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH0PR11MB5506.namprd11.prod.outlook.com (2603:10b6:610:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 02:44:50 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 02:44:50 +0000
Date:   Thu, 8 Jun 2023 10:44:37 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <ZIFAlQAdXfexIDD8@chenyu5-mobl2.ccr.corp.intel.com>
References: <1685555673-2363-1-git-send-email-mikelley@microsoft.com>
 <CAKfTPtAyFqG4W0OAc6pejKdEQ4yTRaoC+qiOZN8sRrwCENmVKA@mail.gmail.com>
 <BYAPR21MB1688C7D7309FEC2B01529C0FD752A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAKfTPtAeA1SxLD7VQ0sVc2G0AAKrNs9ZxoZPj2uR8x5DZQiomQ@mail.gmail.com>
 <ZIACTGpTD7FLfd1K@chenyu5-mobl2.ccr.corp.intel.com>
 <BYAPR21MB1688FE804787663C425C2202D753A@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688FE804787663C425C2202D753A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH0PR11MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e4cf95-5ba4-4f3f-49fd-08db67ca546e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FemO/hnKlwpAGNr+nLLLRRlhh8Q8ZufOM9ywmJuLERrbCIZtoZBT5/VJDuXtGkE/aF59B8KpsAMJOWnBLSpzd3WLjKfZ6MdxnGAvheMcqvW36hWgEQuHqWZ4hLvFi304I4pQXZ9oJ8N5F3ee6F4Js7Uy9HwsAdqdDZKT4IDkJVLK+81z6r/Ok5u7gN+biRjxnB6Hx4zqsvx8hZW5zkAsfTE0N/PNN+3HxNTS14DH4rtdPuQ1fEWg6KVieIt+2MhrTgbgyqFVXP5FIVDc0yx5ro5jDItpVLVxOZ1k/eB3hb84LoAqMRLNVdlEMivvs/PnlpnWcgq1dVFTdvARP1Mx2PZALL+3L4q/dJorriScmKFod8lRHdVnvPtWf6XRWNb7nUEJT+0YlgpSxx0CIK5zBI331Wl3Of2INn4lwabCRwwE2/5FYEQsu5mX099IfnkO6/o51E3U/jb5CxoVM4AXPR4PfZpZKMzbyh1UcNKtcWf0ROu2+BAEw/Q0kX0pnNlhevO/w721QPgcwL3AwzTDlBx5QWFMpUClHht5fF0icOQydkpr77KKEoZe1hPJe9pm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(6486002)(66476007)(82960400001)(66556008)(6916009)(5660300002)(66946007)(54906003)(2906002)(7416002)(4326008)(41300700001)(86362001)(38100700002)(316002)(8676002)(8936002)(6666004)(478600001)(45080400002)(186003)(83380400001)(53546011)(6512007)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tIZpNNd/q60ukIjpVIMDJtNvSQOfM7ivQlUyDWvKFJLkExBDxU0QdbMsdDPq?=
 =?us-ascii?Q?6AldQ0Nmby97JBaAHVCle8iz2KDlQKUVInxp1pXqhka3A65G0bhMrMWCSVou?=
 =?us-ascii?Q?iA9IHvfzYQ7a9A59RBBxHVi/grH7btQrO+7ScjpKjXLDY61slnZ8T0B3AVs7?=
 =?us-ascii?Q?K9mB1pUa82sfKH1ZVZ6vfXk6Q6ythpeG1fCx9z9aVySg2yEvu3td6yUqAIBC?=
 =?us-ascii?Q?taJy5rFsqx4dLXNqmmB7tU3/DEKHUaZI6kjvFeQK4+qqz5SiuGI3c1dLgpdh?=
 =?us-ascii?Q?TwrjMOqrreuvvHwz1FMElBo/LBAmxynU+5/aNw7UGgwShHYbycApffQIE12n?=
 =?us-ascii?Q?lWCQQ4vzCDK+zpEit3WidXJli6qlG5A2n5EKkVb5/P41/XROi5nC08F+rv0I?=
 =?us-ascii?Q?zRcRzStfp4mVlB+HNoa6Jg1V9YOsfTUH7IxkfGah1cPtuQ8IdOxSGeMV/QiA?=
 =?us-ascii?Q?hEvLpxR1YuqKY9vOc+rBpK57MT7o3es09k6KF+lm1zEoDLIUZS8YZQt7Egpg?=
 =?us-ascii?Q?6+8HdhyrUyQCYxI1cbjkU+H6mIsoWkJwtZvYPTyBN7FPYbs4WsfXO26p8HLH?=
 =?us-ascii?Q?xeIvz1wUob1J9etZaAGYAgM5IP4qkNogrMCJj6C8G3qcdiw2VXiQk9brxag1?=
 =?us-ascii?Q?inaeJBpJPpVz8UtJNHKVMkQKLZLsiJD6WxxO1/f4CM/flOQifm5grwGQKmXw?=
 =?us-ascii?Q?fDI8MLjXWWdjucERw3m9phSOU+GpS4f9IGquepoGmZi1RYn5Ev3pXKtrxWbG?=
 =?us-ascii?Q?/ByjzUdy9DgGoCr2v6l8ZazyzYlTcZc4kC/oRsXjcyxjV0ihL5QuehcHImax?=
 =?us-ascii?Q?4sDil7HqIuvAi+sEB1B42EFHccnAbhRPTbKugNiyRTSWELjcyB3J6rov4n7b?=
 =?us-ascii?Q?5SODKAWSA1Wz2/Si/1nE38rsjUKQTpqbHDv/BmXdI2Jk6VXIn0KLBcQXwxM4?=
 =?us-ascii?Q?jdQHCfw9/3kjxTe5b5P4WiBQdWKeMpMx+wKFnnpqMk1yAY4OjVdUjC/G5i2b?=
 =?us-ascii?Q?b+4DW7tQSo6DIjtqJ4czdZ7s5mzGWBs4D9jBeGfkZDQDKIsgQPeblFr+nwHu?=
 =?us-ascii?Q?mngCpl4oJeLVJLGcAqd2vyTmXX4H7f840uGqAXHo2uV1Q+KTucN08MHsXjSP?=
 =?us-ascii?Q?oHssoiGPXkbyhd28P7O1kK8fzQi9/PGR7ZzaYo5BWCh997VW7WlYobAJAF6f?=
 =?us-ascii?Q?45gLrzHJM+n2TphR8NvD1DqHUDlW9SLontd14KdCPm9ksxautpp5HivFc2Ly?=
 =?us-ascii?Q?/7olWyIFNBHfVSaueibeqtH5HGF2xRw4EwHEOAam0TVFnjo4OICcVuCb4CbI?=
 =?us-ascii?Q?1nM8mKh6d4aI9aoc9kH4PM+3n4s9W/+4aue42yQeK9dxMezUgbIIGYimVoSt?=
 =?us-ascii?Q?FZR39+9KdlhR9fwIEVW7qXTSacjBBmtEOOVHCajhx00Hv77WD6AdJvPLLs+2?=
 =?us-ascii?Q?NofaQc4kCg3GzLO9taX+DYqKUAFH1yIyQxchJ08ikxkWV2pPmbo0VDshaHkn?=
 =?us-ascii?Q?oL6xGgZW6m+5z7wF69E5PjYLs61WV2P9GO/VxKU3pCkuruPjqhO4khh2yiLz?=
 =?us-ascii?Q?16v1RZtEvfh/gu9q9NwuKiBGTszjjjkDWV6TNnmT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e4cf95-5ba4-4f3f-49fd-08db67ca546e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 02:44:50.3959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpzX/lmD/XwoSg+cgiuKC2y35pvd4RtO5CmKkxASifZY3/ijBtPfVIrpvD7gMiEqys0RGDsn5qL+BzPE/WGzWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5506
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2023-06-07 at 21:41:46 +0000, Michael Kelley (LINUX) wrote:
> From: Chen Yu <yu.c.chen@intel.com> Sent: Tuesday, June 6, 2023 9:07 PM
> > 
> > On 2023-06-06 at 17:38:28 +0200, Vincent Guittot wrote:
> > > On Tue, 6 Jun 2023 at 16:08, Michael Kelley (LINUX)
> > > <mikelley@microsoft.com> wrote:
> > > >
> > > > From: Vincent Guittot <vincent.guittot@linaro.org> Sent: Monday, June 5, 2023
> > 2:31 AM
> > > > >
> > > > > Hi Michael,
> > > > >
> > > > > On Wed, 31 May 2023 at 19:55, Michael Kelley <mikelley@microsoft.com> wrote:
> > > > > >
> > > > > > With some CPU numbering schemes, the function select_idle_cpu() currently
> > > > > > has a subtle bias to return the first hyper-thread in a core. As a result
> > > > > > work is not evenly balanced across hyper-threads in a core. The difference
> > > > > > is often as much as 15 to 20 percentage points -- i.e., the first
> > > > > > hyper-thread might run at 45% load while the second hyper-thread runs at
> > > > > > only 30% load or less.
> > > > > >
> > > > > > Two likely CPU numbering schemes make sense with today's typical case
> > > > > > of two hyper-threads per core:
> > > > > >
> > > > > > A. Enumerate all the first hyper-theads in a core, then all the second
> > > > > >    hyper-threads in a core.  If a system has 8 cores with 16 hyper-threads,
> > > > > >    CPUs #0 and #8 are in the same core, as are CPUs #1 and #9, etc.
> > > > > >
> > > > > > B. Enumerate all hyper-threads in a core, then all hyper-threads in the
> > > > > >    next core, etc.  Again with 8 cores and 16 hyper-threads, CPUs #0 and
> > > > > >    #1 are in the same core, as are CPUs #2 and #3, etc.
> > > > > >
> > > > > > Scheme A is used in most ACPI bare metal systems and in VMs running on
> > > > > > KVM.  The enumeration order is determined by the order of the processor
> > > > > > entries in the ACPI MADT, and the ACPI spec *recommends* that the MADT
> > > > > > be set up for scheme A.
> > > > > >
> > > > > > However, for reasons that pre-date the ACPI recommendation, Hyper-V
> > > > > > guests have an ACPI MADT that is set up for scheme B.  When using scheme B,
> > > > > > the subtle bias is evident in select_idle_cpu().  While having Hyper-V
> > > > > > conform to the ACPI spec recommendation would solve the Hyper-V problem,
> > > > > > it is also desirable for the fair scheduler code to be independent of the
> > > > > > CPU numbering scheme.  ACPI is not always the firmware configuration
> > > > > > mechanism, and CPU numbering schemes might vary more in architectures
> > > > > > other than x86/x64.
> > > > > >
> > > > > > The bias occurs with scheme B when "has_idle_cpu" is true and
> > > > >
> > > > > I assume that you mean has_idle_core as I can't find has_idle_cpu in the code
> > > >
> > > > Yes.  You are right.
> > > >
> > > > >
> > > > > > select_idle_core() is called in the for_each_cpu_wrap() loop. Regardless
> > > > > > of where the loop starts, it will almost immediately encountered a CPU
> > > > > > that is the first hyper-thread in a core. If that core is idle, the CPU
> > > > > > number of that first hyper-thread is returned. If that core is not idle,
> > > > > > both hyper-threads are removed from the cpus mask, and the loop iterates
> > > > > > to choose another CPU that is the first hyper-thread in a core.  As a
> > > > > > result, select_idle_core() almost always returns the first hyper-thread
> > > > > > in a core.
> > > > > >
> > > > > > The bias does not occur with scheme A because half of the CPU numbering
> > > > > > space is a series of CPUs that are the second hyper-thread in all the
> > > > > > cores. Assuming that the "target" CPU is evenly distributed throughout
> > > > > > the CPU numbering space, there's a 50/50 chance of starting in the portion
> > > > > > of the CPU numbering space that is all second hyper-threads.  If
> > > > > > select_idle_core() finds a idle core, it will likely return a CPU that
> > > > > > is the second hyper-thread in the core.  On average over the time,
> > > > > > both the first and second hyper-thread are equally likely to be
> > > > > > returned.
> > > > > >
> > > > > > Fix this bias by determining which hyper-thread in a core the "target"
> > > > > > CPU is -- i.e., the "smt index" of that CPU.  Then when select_idle_core()
> > > > > > finds an idle core, it returns the CPU in the core that has the same
> > > > > > smt index. If that CPU is not valid to be chosen, just return the CPU
> > > > > > that was passed into select_idle_core() and don't worry about bias.
> > > > > >
> > > > > > With scheme B, this fix solves the bias problem by making the chosen
> > > > > > CPU be roughly equally likely to either hyper-thread.  With scheme A
> > > > > > there's no real effect as the chosen CPU was already equally likely
> > > > > > to be either hyper-thread, and still is.
> > > > > >
> > > > > > The imbalance in hyper-thread loading was originally observed in a
> > > > > > customer workload, and then reproduced with a synthetic workload.
> > > > > > The change has been tested with the synthetic workload in a Hyper-V VM
> > > > > > running the normal scheme B CPU numbering, and then with the MADT
> > > > > > replaced with a scheme A version using Linux's ability to override
> > > > > > ACPI tables. The testing showed no change hyper-thread loading
> > > > > > balance with the scheme A CPU numbering, but the imbalance is
> > > > > > corrected if the CPU numbering is scheme B.
> > > > >
> > > > > You failed to explain why it's important to evenly select 1st or 2nd
> > > > > hyper-threads on the system.  I don't see any performance figures.
> > > > > What would be the benefit ?
> > > >
> > > > As I noted below, it's not completely clear to me whether this is a
> > > > problem.  I don't have a specific workload where overall runtime is
> > > > longer due to the SMT level imbalance.  I'm not a scheduler expert,
> > > > and wanted input from those who are.  Linux generally does a good
> > > > job of balancing load, and given the code in fair.c that is devoted to
> > > > balancing, I inferred at least some importance.  But maybe balancing
> > > > is more important for the higher-level domains, and less so for the
> > > > SMT domain.
> > >
> > > As long as the hyper-threads on a core are the same, I don't see any
> > > need to add more code and complexity to evenly balance the number of
> > > time that we select each CPU of the same core when the whole core is
> > > idle.
> 
> Vincent -- 
> 
> Fair enough.  We can revisit the topic if we discover a workload where the
> imbalance produces a noticeable difference in performance for some reason.
> Thanks for your review and consideration.
> 
> > >
> > In theory if a core is idle, either the 1st hyper thread or the 2nd hyper
> > thread is ok to run the wakee. Would there be a race condition between the
> > check of has_idle_core + idle core checking in select_idle_cpu() and the
> > task enqueue?  If the 2 hyper threads within 1 core are falling asleep
> > and wake up quickly, we have a false positive of has_idle_core, and
> > incorrectly think coreX is idle, and queue too many tasks on the first hyper
> > thread on coreX in B scheme, although coreX is not idle.
> > 
> 
> Chen --
> 
> I have not tried to think through the scenario you describe.  But I don't
> think such a race condition is the primary reason that we observe the SMT
> imbalance when running with CPU numbering scheme B.   It seems like
> such a race would be relatively rare, and hence not a significant issue.  Or
> is there a more serious consequence if the race were to happen?
>
This race condition is just a suspect to cause the imbalance among SMTs,
it does not have direct consequence if the race happens.

thanks,
Chenyu
