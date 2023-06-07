Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE21C7270AA
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jun 2023 23:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjFGVl7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Jun 2023 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFGVl6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Jun 2023 17:41:58 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B8F1BFF;
        Wed,  7 Jun 2023 14:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXExOtezm2VDA3f/uHjdpGsTFP5OqPPu2h1zXH7JhfWZvmGK0P2Hugn8o2uGfyar9xDwCLQoSG5podNJgYHbBy7WTv04sZuLXup53uHjgbsj1A76jyS/ssVNoJsAs3y7RtcWEF3v2CzulTbm3sbLpLXk8EaF45b5CgzZMFuio6NzJRXfajvum+3kfjbzHHeQbVCtGn30FWHsDQtAR61nj6RRcVe6L0WZzi5Gm7zFBMTrbUfh4x2WqDLR+3682uGORvb4oQlhlrK5cyTbx+Mb8WkiIlwXan5V3WzWQFRd4AGskCbOPJQPOMgJauS3HDkT5vCdSw+YZKUJ0dK0GDvS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TETB/o1vXC3YPoqgqP897AhjCY8yr2hBhs9YqWQEu0=;
 b=R7uAaI0zBHJyeOJZ89rhb6G0lKxTBF4WKlWKPh7xYavbdMNrwLAXl3wBYIFaXCbp//xmTcCYK4oDV4qxrv7NnTk26vlV3rMsN+M2iAGPksB8N2dFhRWn7DOaB2atyvgI30g2hYuFg03vm8VX8scU+xyc6QE6+TIx0F7H7lOlvBafLFWPUtt1WbpDcs31CPI+0e8Qcvack6f9OrnLUoeCcJ9Udi2drv+tNw8hvEE8vQnZGStAU6LGimX3ip0hWiEdqLfSaeJOcssLX0BfsWw6T2KvKA0gFRujv354B6/R5QBkLC2YlXnP0wyL5jISLMkfitt4PTyU4eg/13A2cNcdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TETB/o1vXC3YPoqgqP897AhjCY8yr2hBhs9YqWQEu0=;
 b=gLCb+2h/b/2K7SdqNsm0ZEl4OPqS1h5u3pEQQ0uAE6iLy/8e2OC2/ZkoqttSRWgkoHDgDl6BntnZFOpNBYjYJPfvxeK/1z0Z41ePVmDlNYK+sc26QFVGCfrooy1hMTf1M2GvEIJcCJKHrGqQyPe4iuxmuvVPmzLWj0tSRrgL8eI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB2080.namprd21.prod.outlook.com (2603:10b6:510:b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.11; Wed, 7 Jun
 2023 21:41:46 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Wed, 7 Jun 2023
 21:41:46 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
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
Subject: RE: [RFC PATCH 1/1] sched/fair: Fix SMT balance dependency on CPU
 numbering
Thread-Topic: [RFC PATCH 1/1] sched/fair: Fix SMT balance dependency on CPU
 numbering
Thread-Index: AQHZk+kTkbTnALcZ4UCZkSLNi6Kf9697+POAgAHYbWCAACCuAIAA0QcAgADm6wA=
Date:   Wed, 7 Jun 2023 21:41:46 +0000
Message-ID: <BYAPR21MB1688FE804787663C425C2202D753A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1685555673-2363-1-git-send-email-mikelley@microsoft.com>
 <CAKfTPtAyFqG4W0OAc6pejKdEQ4yTRaoC+qiOZN8sRrwCENmVKA@mail.gmail.com>
 <BYAPR21MB1688C7D7309FEC2B01529C0FD752A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAKfTPtAeA1SxLD7VQ0sVc2G0AAKrNs9ZxoZPj2uR8x5DZQiomQ@mail.gmail.com>
 <ZIACTGpTD7FLfd1K@chenyu5-mobl2.ccr.corp.intel.com>
In-Reply-To: <ZIACTGpTD7FLfd1K@chenyu5-mobl2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7818a0e0-fd4b-4a92-8939-1992a3522dd2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-07T17:53:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB2080:EE_
x-ms-office365-filtering-correlation-id: a9fb9134-5eae-469b-a3c9-08db679ffe1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKj5mw8DXJP+oXcJ/34FLjF/z20Mr7/tk6BJlRAYcHpv+9EFGC11GO9XhZfwIk6swcucPxrJ9re6ypvAW+FmPpzHth+ACH5d7YvzXKxSHWwVtPdWKogmYjxoWRbV4FmLIx9yKJbfXmE3JqYSsK329C2hLqaUPjx+72l5bolly5vLWNYeYBfzkJgWuPGKFBuGqYf7hrTpJFrNMeb4pGB8nwUFwWCve1wyq0nDrT9k46TrUPVmNGMtXc0sQskalajdlt3Iaq5+6qF08/wSkP8Ch770sZ4/cPiILvCb9WkTQtZ/DWtsHCLD4co+lrS84NilJwGNzdQ5Lhz0DoppSkOw/vMSoTeVcRXTOGTaBG8MHGs7RL8ggNbDk/tMlp8AzEhB17SP6ZWIS+WK+Hhb9BXcSFbUQguvLaWbjsAN+k/SXZK6q6arG8KkLJ1koE6VfrRooM1FXMFeMO0WtfZhJ/kD0YGn1G4tEr80Sw/VxGyjEkMHPVRY8+07gJpTuMaP/R2lLIRV3exud5ht7K7FuzwU2tu+S09RJz60JDENjhx5ocD1tsDskEvrWVFE9KZEIW82+kGrVzLHpqOC1g6YdFj5m1XJnbIV/O823en4aRBSvUDQOy/OfWxTw1rTUpQL8GkEC901Gj4vde+ZYi180WMIMmr9t4mzchlPSg8U1dswWnE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(8676002)(8936002)(5660300002)(86362001)(8990500004)(110136005)(6506007)(26005)(9686003)(53546011)(2906002)(7416002)(186003)(33656002)(55016003)(52536014)(41300700001)(316002)(38070700005)(38100700002)(82950400001)(4326008)(122000001)(82960400001)(54906003)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008)(71200400001)(7696005)(478600001)(10290500003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zbJQ8D3jb7nUMGKbLsR3o4MaP1HAPkYfTNLYjk+Y6G4izH1BSKYLRHUhmAra?=
 =?us-ascii?Q?822W/raVAmbHo75jIdOnGC3ipW24WX/2ZOMtBPvPp9B0q1eJeiPu+2zwojoF?=
 =?us-ascii?Q?S2GTJVR+Qmx60L06ADIaCCGHHtFYrpeG+TJLNvwgeLwKnC61IefriYbk3TNv?=
 =?us-ascii?Q?vrg58onI/iNY5kyA/SxT0F5Rxjy7ca7oRzOF/9iMOoUo367CrDpT0Fr7+hNK?=
 =?us-ascii?Q?dM7mNUXSa7WiGbELdMiZeZeKbUgMZWmz+bUD0Z+hDWLb6Do8MDzVR0hEiQpY?=
 =?us-ascii?Q?7lfzx4RqyDmG/SmbjxZJvBEAoG7lw0Na/DsRZoYbHxY/PZV9E3AeD47nBebM?=
 =?us-ascii?Q?vy7Jun8K1lzHkYW8QCuwBYIZpIA/8SMqJLNGOBxwOjy3VNBjZHH3gElVQlZC?=
 =?us-ascii?Q?1j9MIw+K1sFJRHTWH2yWUMFtbRgnEiUyGSQTbfRqUaBGrwOurJHZQedLIVkf?=
 =?us-ascii?Q?OJbbdSQyXQl+/NkpqrrMsuQmb1/Cig9GQBlOHJeBAA5JAhJw4Z+QkvuXaqKx?=
 =?us-ascii?Q?ASKOuLsKiY3Kc2DzqL3ELwnx4NR5s7xcpBIinQAV9yaBNSdvbtI0eLQUhR9J?=
 =?us-ascii?Q?Aiuk9/A6WPUaj2wU6UtDPdUqY0uIUFsU6vzYLEBAUdyOdnm1Fycg+noL4lg3?=
 =?us-ascii?Q?7+BNAF/oAgKA/XnDAxzovjMamMymHJ0WcdNStUNuEeK0ouFvbb8GZ5wPiqs2?=
 =?us-ascii?Q?jpYC25BHRcR6M9V8cUqpRlAUlsZMjDblsd86hn//sDtUIG+QaloxMBaODAAj?=
 =?us-ascii?Q?LPO+YXakkLOe0GyDX+rRHqw0KpkuXzFK9MQ9dCH0onR1jFZZHEMGDNyyQnOC?=
 =?us-ascii?Q?3qDH+mhhYKcjEka03ZgJweVbsqaw66hZe8h6ohdxFOaGNuqm/c8ABZiQS1oF?=
 =?us-ascii?Q?9DXWLBpko32QUn2YrRu6smFmWEhqAjo54FGiiZ+HRcr5a4vWiOfRAEzIaRrz?=
 =?us-ascii?Q?eV/SGSMpQ64Zjq/a5erdh5ACSaVyRYEP7jdFpYZ1WAgf4tmaKwh3Fyd/0PMt?=
 =?us-ascii?Q?LSwlFeLCN/ZP1pv2Wmnn2KqMldWKdpVDkMbBwh+dmUeUeoMZ3nwlCnaqekkS?=
 =?us-ascii?Q?tI2zGHHaa/jFHH54M8DNfNEEVq0Vq5rFEPj5cuPxXA/T41TDxggqI8x2o+wu?=
 =?us-ascii?Q?9yqUSvQqCznyGEm/V5q/nU0G1BmNcviu4ZCL5Kszmkt7k3AS4h2hdv6Rjnrh?=
 =?us-ascii?Q?eYQ/wE9nGvjxACox+XRQ1MmCdVF9v7yjTuKUbQTE2X2G3V25B5gWcQ6a9mBO?=
 =?us-ascii?Q?BwOfjR/AZcbbxifmJRvjvjhTOCMJkhz7ERRBwUZE1Wn2YixGo+Nqi3TsayAG?=
 =?us-ascii?Q?qeHtMLakOSHvlk9Y5Mm7E0P7GiaSJzDcKmzyMdo+1Jq47960h85fAdCdID9Q?=
 =?us-ascii?Q?Ep2N/SP4mCm+q1mQ4XgW50QRpj9NsFih0XILmozB1YJIKgzK7C0n9GpWP+Vn?=
 =?us-ascii?Q?f9Q2aVqAjk+5RYC+6hnPfmJ7FSK/d9BB195Kaz+VxoQ6G7Uot8sQk8RKEzoV?=
 =?us-ascii?Q?xjSSRqqnuBIn2pgls6Ozgq50CqEebBoMRnBuxhXO1HTo+G/ajpcIy+D9yzsc?=
 =?us-ascii?Q?lzOfSSj76n3I60MmWoObx9qWWXTLqhRtnIlQ6xUsQN5rDZim2zwsEdQeQk2x?=
 =?us-ascii?Q?9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fb9134-5eae-469b-a3c9-08db679ffe1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 21:41:46.3931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GaNh1ousXj5ghSMJRvKyBf5yKSaq4Q2vtbUZjKMloka041RiWiCs3F85nU54IzkW//r5HyPDQLiUn9ugZlwng/oo0RKgYGNjTrzA7jNPwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com> Sent: Tuesday, June 6, 2023 9:07 PM
>=20
> On 2023-06-06 at 17:38:28 +0200, Vincent Guittot wrote:
> > On Tue, 6 Jun 2023 at 16:08, Michael Kelley (LINUX)
> > <mikelley@microsoft.com> wrote:
> > >
> > > From: Vincent Guittot <vincent.guittot@linaro.org> Sent: Monday, June=
 5, 2023
> 2:31 AM
> > > >
> > > > Hi Michael,
> > > >
> > > > On Wed, 31 May 2023 at 19:55, Michael Kelley <mikelley@microsoft.co=
m> wrote:
> > > > >
> > > > > With some CPU numbering schemes, the function select_idle_cpu() c=
urrently
> > > > > has a subtle bias to return the first hyper-thread in a core. As =
a result
> > > > > work is not evenly balanced across hyper-threads in a core. The d=
ifference
> > > > > is often as much as 15 to 20 percentage points -- i.e., the first
> > > > > hyper-thread might run at 45% load while the second hyper-thread =
runs at
> > > > > only 30% load or less.
> > > > >
> > > > > Two likely CPU numbering schemes make sense with today's typical =
case
> > > > > of two hyper-threads per core:
> > > > >
> > > > > A. Enumerate all the first hyper-theads in a core, then all the s=
econd
> > > > >    hyper-threads in a core.  If a system has 8 cores with 16 hype=
r-threads,
> > > > >    CPUs #0 and #8 are in the same core, as are CPUs #1 and #9, et=
c.
> > > > >
> > > > > B. Enumerate all hyper-threads in a core, then all hyper-threads =
in the
> > > > >    next core, etc.  Again with 8 cores and 16 hyper-threads, CPUs=
 #0 and
> > > > >    #1 are in the same core, as are CPUs #2 and #3, etc.
> > > > >
> > > > > Scheme A is used in most ACPI bare metal systems and in VMs runni=
ng on
> > > > > KVM.  The enumeration order is determined by the order of the pro=
cessor
> > > > > entries in the ACPI MADT, and the ACPI spec *recommends* that the=
 MADT
> > > > > be set up for scheme A.
> > > > >
> > > > > However, for reasons that pre-date the ACPI recommendation, Hyper=
-V
> > > > > guests have an ACPI MADT that is set up for scheme B.  When using=
 scheme B,
> > > > > the subtle bias is evident in select_idle_cpu().  While having Hy=
per-V
> > > > > conform to the ACPI spec recommendation would solve the Hyper-V p=
roblem,
> > > > > it is also desirable for the fair scheduler code to be independen=
t of the
> > > > > CPU numbering scheme.  ACPI is not always the firmware configurat=
ion
> > > > > mechanism, and CPU numbering schemes might vary more in architect=
ures
> > > > > other than x86/x64.
> > > > >
> > > > > The bias occurs with scheme B when "has_idle_cpu" is true and
> > > >
> > > > I assume that you mean has_idle_core as I can't find has_idle_cpu i=
n the code
> > >
> > > Yes.  You are right.
> > >
> > > >
> > > > > select_idle_core() is called in the for_each_cpu_wrap() loop. Reg=
ardless
> > > > > of where the loop starts, it will almost immediately encountered =
a CPU
> > > > > that is the first hyper-thread in a core. If that core is idle, t=
he CPU
> > > > > number of that first hyper-thread is returned. If that core is no=
t idle,
> > > > > both hyper-threads are removed from the cpus mask, and the loop i=
terates
> > > > > to choose another CPU that is the first hyper-thread in a core.  =
As a
> > > > > result, select_idle_core() almost always returns the first hyper-=
thread
> > > > > in a core.
> > > > >
> > > > > The bias does not occur with scheme A because half of the CPU num=
bering
> > > > > space is a series of CPUs that are the second hyper-thread in all=
 the
> > > > > cores. Assuming that the "target" CPU is evenly distributed throu=
ghout
> > > > > the CPU numbering space, there's a 50/50 chance of starting in th=
e portion
> > > > > of the CPU numbering space that is all second hyper-threads.  If
> > > > > select_idle_core() finds a idle core, it will likely return a CPU=
 that
> > > > > is the second hyper-thread in the core.  On average over the time=
,
> > > > > both the first and second hyper-thread are equally likely to be
> > > > > returned.
> > > > >
> > > > > Fix this bias by determining which hyper-thread in a core the "ta=
rget"
> > > > > CPU is -- i.e., the "smt index" of that CPU.  Then when select_id=
le_core()
> > > > > finds an idle core, it returns the CPU in the core that has the s=
ame
> > > > > smt index. If that CPU is not valid to be chosen, just return the=
 CPU
> > > > > that was passed into select_idle_core() and don't worry about bia=
s.
> > > > >
> > > > > With scheme B, this fix solves the bias problem by making the cho=
sen
> > > > > CPU be roughly equally likely to either hyper-thread.  With schem=
e A
> > > > > there's no real effect as the chosen CPU was already equally like=
ly
> > > > > to be either hyper-thread, and still is.
> > > > >
> > > > > The imbalance in hyper-thread loading was originally observed in =
a
> > > > > customer workload, and then reproduced with a synthetic workload.
> > > > > The change has been tested with the synthetic workload in a Hyper=
-V VM
> > > > > running the normal scheme B CPU numbering, and then with the MADT
> > > > > replaced with a scheme A version using Linux's ability to overrid=
e
> > > > > ACPI tables. The testing showed no change hyper-thread loading
> > > > > balance with the scheme A CPU numbering, but the imbalance is
> > > > > corrected if the CPU numbering is scheme B.
> > > >
> > > > You failed to explain why it's important to evenly select 1st or 2n=
d
> > > > hyper-threads on the system.  I don't see any performance figures.
> > > > What would be the benefit ?
> > >
> > > As I noted below, it's not completely clear to me whether this is a
> > > problem.  I don't have a specific workload where overall runtime is
> > > longer due to the SMT level imbalance.  I'm not a scheduler expert,
> > > and wanted input from those who are.  Linux generally does a good
> > > job of balancing load, and given the code in fair.c that is devoted t=
o
> > > balancing, I inferred at least some importance.  But maybe balancing
> > > is more important for the higher-level domains, and less so for the
> > > SMT domain.
> >
> > As long as the hyper-threads on a core are the same, I don't see any
> > need to add more code and complexity to evenly balance the number of
> > time that we select each CPU of the same core when the whole core is
> > idle.

Vincent --=20

Fair enough.  We can revisit the topic if we discover a workload where the
imbalance produces a noticeable difference in performance for some reason.
Thanks for your review and consideration.

> >
> In theory if a core is idle, either the 1st hyper thread or the 2nd hyper
> thread is ok to run the wakee. Would there be a race condition between th=
e
> check of has_idle_core + idle core checking in select_idle_cpu() and the
> task enqueue?  If the 2 hyper threads within 1 core are falling asleep
> and wake up quickly, we have a false positive of has_idle_core, and
> incorrectly think coreX is idle, and queue too many tasks on the first hy=
per
> thread on coreX in B scheme, although coreX is not idle.
>=20

Chen --

I have not tried to think through the scenario you describe.  But I don't
think such a race condition is the primary reason that we observe the SMT
imbalance when running with CPU numbering scheme B.   It seems like
such a race would be relatively rare, and hence not a significant issue.  O=
r
is there a more serious consequence if the race were to happen?

Michael


