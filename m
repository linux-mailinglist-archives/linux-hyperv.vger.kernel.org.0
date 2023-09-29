Return-Path: <linux-hyperv+bounces-346-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B97B39EE
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9EA82282CA0
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 18:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034A66696;
	Fri, 29 Sep 2023 18:20:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9E6666A
	for <linux-hyperv@vger.kernel.org>; Fri, 29 Sep 2023 18:20:29 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD30136;
	Fri, 29 Sep 2023 11:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+YNJ5lHNU4qjF6nZhzAEHhIAlODolFGFf0gtVCcDagOxXPHWF5E35kYCZxS39In6/dWXmpG3NPUtqTJ/Y2NZAh27pwALhysvcQoFQ/jOPHTvt0m8WdRxvBB/a2Ia6IMGOjhUlFHNeHr/RZnhRwCjQJEb6VBRAHqx7SkQgtQT1guw+MmUZmeGcBfTUMr+0aJbhLj+teG34OJuL775fUUWQ6BV4jdu0O+ksZSCP5rRVS7/WGDfNMRNrBwylFebzk+CXFd0Ro4vloKFVj0rgsaWwSepX9PLlfBW4TZiXrexCRDreECcLL1PeF/OUgQpGtkN8RUYBplUA7VBjdrjftUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xycPPMLoAFblCRg2Tr3wiRC8N0eGwJc9DrrmmZP3F/8=;
 b=ZotuWgZRKcJLXBA6+fVUgSgp77y3SxTRrbadIctIONb/BJp+zqtUVm6iY4BkRfnMAQSVljZQFwLS6ui5ig7gweCvUcmMQMlNvgLWmk3toGnexNQT0u/CyAXI+hDIuAppK8rOFbmmptkcADeXGxOdj6xCCX1DhWWfvn2kpcP/lHti7rQmUxhn+WwC56jBN1kD2w9vR6zMoqcXsoqSt5qKm5Q+gembdkDZvFRQPUYFPcP6Y0PvS9lwxeKIuMNjopXsJmbsig9DMe6Ua84ev35lJaDIXz0uEMMS+SOPU/m0fT8IzIle73JZOhpoiyfLuaM+JCrJ7agdRo8J9pBhidRwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xycPPMLoAFblCRg2Tr3wiRC8N0eGwJc9DrrmmZP3F/8=;
 b=PM7pSkxrwVtGXYHJMyFPCywhZq/Q9pxLAzMlzgcO+N4IBY+AR4k2eODNKLjDfAxQX79UU5+IncnbSMOvvvuqRNrU6xjN49DlwbUqpZHnDRQfP4D48iXsQlZFQ2mrkJxIHTr8fgIrY+cv5OrHqGH+o+wmHBSiEHDfI5JTtk/xTjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by BL1PR21MB3377.namprd21.prod.outlook.com (2603:10b6:208:39d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.14; Fri, 29 Sep
 2023 18:20:22 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::eff:aea7:be24:8e44%4]) with mapi id 15.20.6863.013; Fri, 29 Sep 2023
 18:20:22 +0000
From: Michael Kelley <mikelley@microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	thomas.lendacky@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kirill.shutemov@linux.intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	x86@kernel.org
Cc: mikelley@microsoft.com
Subject: [PATCH 0/5] x86/coco: Mark CoCo VM pages not present when changing encrypted state
Date: Fri, 29 Sep 2023 11:19:04 -0700
Message-Id: <1696011549-28036-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR22CA0048.namprd22.prod.outlook.com
 (2603:10b6:930:1d::29) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|BL1PR21MB3377:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fcccab-5bd0-42fe-a4f5-08dbc118be6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+JalQnvniGwB6ca9vZ07tMsJZYBBUgYaBeIPOX/azta8SBgQP9ejZ9wCNaYg6YAwyk1LN1W7vlNdLPLClz2fBMYGvdyLgv808VTdIPDTNDFLoqEyCmjhG2vaPIA8zmi/mrTsarPZFNriVr/NkkFtfeNN94grRJ/Kq3uVMluFL3i6flvcfu4Hw/Sw+x0VBIEC8gwfGdESK4EAtTfNkX8vi0bnVU7owlftcBysPv9VlxW4xiXGY3S9nehO36jrofGM8dbdoeOZ+xe74PcrvpDs/d0bW8sGIIglP2veQLOOX1QWOjz3ipcWSB9hWqcVTl/6LfbA+/dBF6834gfwM2x4uc0PxHKIHKCbIJNUcbyE3NteDqYc439+RxIRFfz4OOKwP3G2mylb3D6GRybJCmuC0KeeZlAZs9SCI/eikopm+llmjS1lPVSzcTzwUxjT0Xm2N7ZbPnaasRoa3S/OpZHjVEzyWQe6RAuaYNPATFDphjTZFVeuKm5sWlKmYmq4mb3BNrgaQHFgBWibPc+Wl7Lvi4FAgomj2qLLsNc/ZsSp8hxi9ywbhEEAbQsm6Y07HwNAdpVqBCHhtofttl3aFT67YHyR1/IRyIZZ35wonWsGfKDZdbO67n4tz9XYwAPYde24HqX4lnqsAzeFhJIPYArzlBykc/yWSMwws64x/g9OOUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(41300700001)(6506007)(6512007)(6486002)(52116002)(478600001)(6666004)(966005)(2616005)(2906002)(316002)(66946007)(66556008)(66476007)(5660300002)(107886003)(10290500003)(8676002)(8936002)(4326008)(26005)(7416002)(921005)(82950400001)(82960400001)(36756003)(86362001)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GdTNNh+yCp1z1bzUOsYqWsPz8MwMUAMZ5K1TaSHNuwEbiuVh22s1d750PXUx?=
 =?us-ascii?Q?iro+fdd5nZLCCR1EbR9aicm1e2kCeXfLZGHT0+DQrlup4x4CNgRIuDYfit4m?=
 =?us-ascii?Q?jhRwqJjSZTNmSeDEZ+xpsOdKyLop0L5Fml8E1Ba+8WQfMOeBnQBPjVVdvaBZ?=
 =?us-ascii?Q?w34NPdz0KfWQ8wTxuDXzR4vXIalgqY8O4Y8ruuVzQ7vK146s/4ntn9CKq908?=
 =?us-ascii?Q?aMf984oOV/M4dURAJa0b7NnTgU7V0wRtIhbzCRlXVPdfxQqJ0hbwOnausMUx?=
 =?us-ascii?Q?HdwErXOJCuSwAAyvUXsuMlU3dFdZhmCeLCLnQBJ5LEQUETwDaFPAq7LabiDJ?=
 =?us-ascii?Q?Ky8UKPKE/rPG18Cg7M7/aF9nwMgkp7Eq3YaxQ+ennIhELb6CBz/gz4pdimm1?=
 =?us-ascii?Q?fLindki6NkURpuf3kAdCnvaLOvOu2PoEAu8fW+KSy29PGvtCBsDn8RNnzV0r?=
 =?us-ascii?Q?Hj8nuSQzV3im+pWMzNGtWc755oDM7/8Yj+rdlwDKPhEN1gwf81qOAKnoUK0+?=
 =?us-ascii?Q?iEpUI5EoFYggiSFgFtfu6Qv5KZu83xlqESySoefnL0Fczaw5nc2TUKFL+0Bx?=
 =?us-ascii?Q?CGrTDwgfdGA6+E71RV1kKoWYzqvoZZwgZctXFhLmPvRRhCR++bV8z2OH2jP8?=
 =?us-ascii?Q?GjqX9SGIGRni9HRkKGQ7OHeaSFxOD7uqLzU6qbFbrTrL/UZYOckwi+8zbRM0?=
 =?us-ascii?Q?ppM/teckbkNAU+diPQKV+58jNd801/vYQQoSUtSs/aJuuuYm/9QMeV976Iir?=
 =?us-ascii?Q?WeD2ArADwXYekhwvxhgPEGB4GWLLX7/vpY8UvuvT+c4AlG2WRy9q08leIg5o?=
 =?us-ascii?Q?EGWQxRRfW46Z0RIAACPVI4y2B74RCXiJQAzW0uJ8s58r5fJmLBrQhT9teMp2?=
 =?us-ascii?Q?dzVQ1WymLs1ORaSFO10KrXYXTQC+JbOage0JOJUOBexNoiqaXj6pTZgYMeez?=
 =?us-ascii?Q?yiJj+nWRqCE8JfplqMFzRozfbSbm3LAY858LaTYHPEKliWnkPYlpobnplHen?=
 =?us-ascii?Q?8f0xRDQx0MwyqjX6cyltJb0TIWAatZMY/v67WaCyjPytpdFOPZXxewIFMcUI?=
 =?us-ascii?Q?lOBce8+4sggeUaVMt5I7IsXhEko1kaIXPZsSe1kVr7Vlg87CMch5IW339u67?=
 =?us-ascii?Q?z0IakRRfDnLecYbkdYDgrJeIsrxMQdn61L57IoW6cyDD1mqYu2f34JhSgJuF?=
 =?us-ascii?Q?ZwrfemJKbJY9L46PmcrRY0Bi9klLWrOq2kFHVjI8qJ1pyWdB/v8tT2+Yn1LD?=
 =?us-ascii?Q?AYKW6BTsTEHkCdyY9psFUn7K0xPnr6xWtI8fSfVg2hgMcgyhE1H9EiC7o5Em?=
 =?us-ascii?Q?mlxznONIINJr4hPFMTUJi5fmEUXpHQy1WnMk4iQ5SbA1qy8GOg8QtuNN0OYq?=
 =?us-ascii?Q?fQDMtGwo7MnB5aKn3MZ6pKzJHtWGe9shqM5+WvJPOypvGE6Ug/jZOag4UH6x?=
 =?us-ascii?Q?4lIArZGtTtgYKa5dh/msJMTOZ4XlzvpZpZEFz3FEW50e3r8mSP9Xk/LtjbNB?=
 =?us-ascii?Q?vmJX1bmmvRMHxg8E/3YPtj32qOdpW+AVtk4KQ8eqBU/ST6r4zzGc/VsXAkeF?=
 =?us-ascii?Q?OINB94jVm05nn4Fs25QBDtfoL6GbcMVSeKrC/EPndki9zzrJI868WSxtNAG9?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fcccab-5bd0-42fe-a4f5-08dbc118be6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:20:22.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14K4EZThbEAlwuhOk5IjJJ1gT1DJLNwVAnPUjYejWc4bYxSmyd/1mXBLmNPqdke8R4fKD3eX93fqpu/4RkDCag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3377
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In a CoCo VM when a page transitions from encrypted to decrypted, or vice
versa, attributes in the PTE must be updated *and* the hypervisor must
be notified of the change. Because there are two separate steps, there's
a window where the settings are inconsistent.  Normally the code that
initiates the transition (via set_memory_decrypted() or
set_memory_encrypted()) ensures that the memory is not being accessed
during a transition, so the window of inconsistency is not a problem.
However, load_unaligned_zeropad() can read arbitrary memory pages at
arbitrary times, which could read a transitioning page during the
window.  In such a case, CoCo VM specific exceptions are taken
(depending on the CoCo architecture in use).  Current code in those
exception handlers recovers and does "fixup" on the result returned by
load_unaligned_zeropad().  Unfortunately, this exception handling can't
work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode).
The exceptions would need to be forwarded from the paravisor to the
Linux guest, but there's no architectural spec for how to do that.

Fortunately, there's a simpler way to solve the problem by changing
the core transition code in __set_memory_enc_pgtable() to do the
following:

1.  Remove aliasing mappings
2.  Flush the data cache if needed
3.  Remove the PRESENT bit from the PTEs of all transitioning pages
4.  Set/clear the encryption attribute as appropriate
5.  Flush the TLB so the changed encryption attribute isn't visible
6.  Notify the hypervisor of the encryption status change
7.  Add back the PRESENT bit, making the changed attribute visible

With this approach, load_unaligned_zeropad() just takes its normal
page-fault-based fixup path if it touches a page that is transitioning.
As a result, load_unaligned_zeropad() and CoCo VM page transitioning
are completely decoupled.  CoCo VM page transitions can proceed
without needing to handle architecture-specific exceptions and fix
things up. This decoupling reduces the complexity due to separate
TDX and SEV-SNP fixup paths, and gives more freedom to revise and
introduce new capabilities in future versions of the TDX and SEV-SNP
architectures. Paravisor scenarios work properly without needing
to forward exceptions.

This patch set is follow-up to an RFC patch and discussion.[1]
Compared with the RFC patch, the steps listed above are optimized for
better performance and particularly for fewer TLB flushes.

Patch 1 handles implications of the hypervisor callbacks in Step 6
needing to do virt-to-phys translations on pages that are temporarily
marked not present.

Patch 2 is a performance optimization so that Step 7 doesn't generate
a TLB flush.

Patch 3 is the core change that implements Steps 1 thru 7. It also
simplifies the associated TDX, SEV-SNP, and Hyper-V vTOM callbacks.

Patch 4 is a somewhat tangential cleanup that removes an unnecessary
wrapper function in the path for doing a transition.

Patch 5 adds comments describing the implications of errors when
doing a transition.  These implications are discussed in the email
thread for the RFC patch.

With this change, the #VE and #VC exception handlers should no longer
be triggered for load_unaligned_zeropad() accesses, and the existing
code in those handlers to do the "fixup" shouldn't be needed. But I
have not removed that code in this patch set. Kirill Shutemov wants
to keep the code for TDX #VE, so the code for #VC on the the SEV-SNP
side has also been kept.

This patch set is based on the linux-next20230921 code tree.

[1] https://lore.kernel.org/lkml/1688661719-60329-1-git-send-email-mikelley@microsoft.com/

Michael Kelley (5):
  x86/coco: Use slow_virt_to_phys() in page transition hypervisor
    callbacks
  x86/mm: Don't do a TLB flush if changing a PTE that isn't marked
    present
  x86/mm: Mark CoCo VM pages not present while changing encrypted state
  x86/mm: Remove unnecessary call layer for __set_memory_enc_pgtable()
  x86/mm: Add comments about errors in
    set_memory_decrypted()/encrypted()

 arch/x86/coco/tdx/tdx.c       |  66 +-----------------------
 arch/x86/hyperv/ivm.c         |  15 +++---
 arch/x86/kernel/sev.c         |   8 ++-
 arch/x86/kernel/x86_init.c    |   4 --
 arch/x86/mm/mem_encrypt_amd.c |  27 +++-------
 arch/x86/mm/pat/set_memory.c  | 114 +++++++++++++++++++++++++++++-------------
 6 files changed, 102 insertions(+), 132 deletions(-)

-- 
1.8.3.1


