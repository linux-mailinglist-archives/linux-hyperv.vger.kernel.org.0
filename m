Return-Path: <linux-hyperv+bounces-10221-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLyiMwtI5mkPuQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10221-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 17:36:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0442E63B
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 17:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC5B33000FDE
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA552329C54;
	Mon, 20 Apr 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGg/M9k2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C017A31C
	for <linux-hyperv@vger.kernel.org>; Mon, 20 Apr 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699061; cv=pass; b=NpDfvh0ooSchQQ3mBrZT+OYMNBvtXTUoCYiUlTsKBmQyw6uaf3Z2E6lwQLm2BSLoTKi7HozMw7mG4JPQtoylZHUaTlQmRLxBiCucisqmhOI6m9hBgSt7NNr2eBQN5VR1Cc2iOyFPGecJCQfOEgkoHXP3Cy/XQdz5HVgbOwvfwSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699061; c=relaxed/simple;
	bh=Uh5pfsYmCPhzRY/dWjPf4I3pFWo/VJ6Grq7f8Ql5qVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LR8W1BIxj1sKJDruxODcdOjTw8xvVA75dX0n6Lo9zNmAMSAiZJQ6CFV/pVwWYMMMISRUdlDXp83ljYA13DG58C3xVQxh9xndd8PJ7lTonoP34GMcIx8urIhxokEqHbCslxPfylmu3ro9I8JGigF5/fdjopBg4toNVXxRdaUSbeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGg/M9k2; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7a43424f861so31637437b3.1
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Apr 2026 08:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776699058; cv=none;
        d=google.com; s=arc-20240605;
        b=I3QPM3+jCAGzvHeOxKVLu9i6eKiHdMiNtw1Hf+BcvwXGu7VS8nuKGS+xNruGBGD00z
         J7PODY2zdofRXehYRdO3FJZgqA7zWB3yq4QP06pugj8oZgoVqmVDfTXe4QmmIXvaAJhA
         moBs3zVpBaBwI2sQtQO/TLYpI05w7U7+8bmFq4gc5Qj6tCpINEs6zettkncd7+rMTFt9
         UHtXU0SWFLi5IPE0owf6YnUVQ7T/JB6JzRLcNYMvDbh8V3jmK9+i0rYtsfTIfTaZDqYj
         6TjHi7AS5vNxb77m7GBmj7l2+h1Vmj9aFE3fjJ4J9p7WNKf5h8KpNvx2uZ9qn4sbJaK/
         CIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9YI76BZ64U7Q7S2rYdBngk+FjiU3Qud+2ZNj6k+ePsY=;
        fh=orvWg0WvDJbzOZaL+kXBN+AX/Xh608MHpPG2+y8/Vg4=;
        b=UoTnSp0xtqFK2L0h9dX8SHCVaewWuqYTUXdjJDdUtLSfuiXCTvTNmJalbyJE1hzKUt
         1W6Cj1Nes6EpwKGprw3Rme8iOx/MZuqFnG6DmSOhBTekV+ffVldW2pr5doxcXCCQfrTy
         7+j+WcWSJ/DEkvp3fyBsGuU7Nh+wFOcFUYPOaXW2qznWSc04QCbWU0SVSPnLkjhobN0Z
         0T72GPZx7Of5HRIdAl9HZ0NXmlmM+HJayPIhM910XsfPxt1Mv/uRAN+h3xiBZ7bi66L7
         +xGg5MttYPNFBG0f7xUh6YyBh/r0e/mZT+FmnyJYCbfMd4cPY7g1PJv4CIMNwQ3lMR8G
         ox5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776699058; x=1777303858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9YI76BZ64U7Q7S2rYdBngk+FjiU3Qud+2ZNj6k+ePsY=;
        b=jGg/M9k2geT3qkv5Z4Y0eCHZQWJqiPQa6f+n+ZFuMTdHJEv0uIFEUUDM55AxZx9wmD
         G2GaNNV6wZLhgMvkrle7PD88RHWljCrg72rfPxidE3LA6hU6fNleZgexn/TDuEckT6k3
         5xsBKvlXmQQdD3EwHOB46faGZysIOxVbcKGx+lP4k9RHYVUHR20mCQpEmkYoHb03p8YD
         qyO2sS927uQ+ESEwHIiKYSifcaNyUG39ebybTPvYSGObXsO8/kUzKMWT2KYnENhGbIZL
         B2xV/tk3Y1OszIGuPbor6nt8mrB/sBB4UixsbYl/4Tczfd+Z1BwoRse2UcaTnnLgosG0
         IUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776699058; x=1777303858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YI76BZ64U7Q7S2rYdBngk+FjiU3Qud+2ZNj6k+ePsY=;
        b=dJ9wr8t864qTsKqxdguCQaGYS4Ac2cOsm+1D3pAK0uMY5+PKrYVoKZtsXkYC+1KqXF
         yplpvLUw6/tcFRHjPH3uVrCEF7t154TMc71UCt1vpv/FbwaCLV6BPQIB6Ptx+KfQCSN0
         UHSdVkamqlcSGWknWPo8zb5H5QGXpJ57k3ehlkPXaGp75cNjoEcRanUJzUOWrEENbBQN
         FCafZJZMjLCatgACQLpHeAypNxNsejWUcXpupSljg3trxQ7EKN7Q4PqgnOPIuwCfvh1c
         7eOnHFN6Nc6PZoP8x8qm2aoircDPvY0Zy3j9qRKNRmq421G6z7jadYS923+WZOeB51BK
         CX1g==
X-Gm-Message-State: AOJu0YyLapik1zBitNFPRu77ilxAcVAC3fVvvBZGeFNUx8VM9UFTXaoS
	xlDlp63XhRQqxg8GLiHUqqZcSa7XIG/LmP/eI0mUD1XgENuzy0g0yllh2dJTAAvNBlJgYrmSrnx
	+H9bZjkUEd22tXrlJO6VFAs/mF8ptJ1BEnYC0
X-Gm-Gg: AeBDietPCxhOYSH1+fLXTVM0iAOuodYyK3eakuAH5NE612GmoqbI9XSa/Ntp8log0Ay
	bTtsqKrYOdq+KgnbQFe/yn2XVwfiPzH5KDRlpsy4cjdC7hqsTgsaZTvf+1T8pXV1ypeFxvsA4kY
	EBKmawdrqjuHzL5ZErE+D6tRiMrlHlvueMiY+/MU1HIOZUFkyyJLYs6pEiGUmd0gqk8U6KLQd1Q
	x0lOkdOZ6DZFcBVb1aprNM4eIeK2LFUVDAmdOueLbuBLwPWrApWKuFA7rDJKGm+JlGGZnUkZwhw
	7FSsEbVaHttUBSaZdVY=
X-Received: by 2002:a05:690c:7283:b0:7b3:edc7:9bb8 with SMTP id
 00721157ae682-7b9eccb73a9mr148684657b3.0.1776699058122; Mon, 20 Apr 2026
 08:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPLehQ3cT+jEUkLnfBYFh3a=eCZcxzBeDvTX-B0MWdSJ_oEFuQ@mail.gmail.com>
In-Reply-To: <CAPLehQ3cT+jEUkLnfBYFh3a=eCZcxzBeDvTX-B0MWdSJ_oEFuQ@mail.gmail.com>
From: Boiler Plate <boilerplate4u@gmail.com>
Date: Mon, 20 Apr 2026 17:30:46 +0200
X-Gm-Features: AQROBzC75VOeiI6HVTYfyBivYNjB_NABcla4QmLtvqKT9N00HaUz8T0_RWBKnQw
Message-ID: <CAPLehQ1P6T+PuC4=FNPPuwu8QrSeEjMP=fvNYYBKz_t3ckRocw@mail.gmail.com>
Subject: [BUG/RFE] hv_balloon: hot-add not triggered under burst memory demand
To: linux-hyperv@vger.kernel.org
Cc: wei.liu@kernel.org, mhklinux@outlook.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10221-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boilerplate4u@gmail.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 75D0442E63B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi !

I'm experiencing a consistent failure of the hv_balloon driver to
respond to burst memory demand on Alpine Linux, with VS Code Remote
devcontainers as a
representative workload.

The issue has been thoroughly analyzed using PSI monitoring and kernel
configuration verification. The root cause is the absence of burst
demand support in the driver architecture, compounded by the 1-second
polling loop latency.

A detailed analysis with measurement data and proposed improvements down below.
--

Bug Report / Request for Enhancement: hv_balloon Dynamic Memory
Hot-Add Fails Under Burst Demand Workloads

SUMMARY

The Linux hv_balloon driver for Hyper-V Dynamic Memory is documented
and architecturally designed to manage guest memory in both
directions: increasing memory via hot-add when the guest needs more,
and decreasing it via balloon inflation when the guest needs less. The
original patch comment introducing the driver explicitly states this
dual purpose, and the driver's state machine contains distinct states
for DM_BALLOON_UP, DM_BALLOON_DOWN and DM_HOT_ADD.

In practice, only the downward direction works reliably. This was
demonstrated in a controlled test running Alpine Linux v3.23 (kernel
6.18.20-lts) as a Hyper-V guest with Dynamic Memory configured
(Startup RAM 1024 MB, Maximum 16384 MB). Under a representative burst
demand workload using VS Code Remote SSH with devcontainer startup,
the guest experienced 97% PSI memory stall, 176,000+ swap pages
written, and near-OOM conditions over a sustained period exceeding 150
seconds. During this entire period, MemTotal never increased by a
single kilobyte and dmesg showed zero hot-add activity. The upward
direction failed completely.

The root cause is the complete absence of burst demand support in the
driver architecture, compounded by a fixed-interval 1-second polling
loop between guest and host, sequential hot-add protocol semantics,
and a kernel default configuration (MHP_DEFAULT_ONLINE_TYPE_OFFLINE)
that leaves hot-added memory sections offline even when they do
arrive. Collectively these mean the driver cannot respond to burst
memory demand fast enough to be useful.

Proposed resolution: PSI-triggered hot-add requests independent of the
1-second polling loop, documentation of required
auto_online_blocks=online configuration, and improved diagnostics when
hot-add is not initiated despite high memory pressure.


1. VERIFIED PURPOSE AND DESIGN INTENT

The original patch introducing hv_balloon into the Linux kernel states
explicitly:

"Windows hosts dynamically manage the guest memory allocation via a
combination memory hot add and ballooning. Memory hot add is used to
grow the guest memory up to the maximum memory that can be allocated
to the guest. Ballooning is used to both shrink as well as expand up
to the max memory."

Source: K.Y. Srinivasan, [PATCH 2/2] Drivers: hv: Add Hyper-V balloon
driver, lkml.iu.edu, 2012.

The driver's state machine in the current kernel source at
drivers/hv/hv_balloon.c confirms this with explicit states
DM_BALLOON_UP, DM_BALLOON_DOWN and DM_HOT_ADD. Source:
github.com/torvalds/linux/blob/master/drivers/hv/hv_balloon.c
(verified April 2026).

The upward direction is therefore not an optional or aspirational
feature. It is the primary stated purpose of the hot-add component of
the driver.


2. SYSTEM CONFIGURATION

Host: Windows Server 2022 with Hyper-V, Dynamic Memory enabled

Guest OS: Alpine Linux v3.23, kernel 6.18.20-lts (x86_64)

Kernel config relevant to this report:
- CONFIG_MEMORY_HOTPLUG=y
- CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE=y (Alpine default)
- CONFIG_PSI=y
- CONFIG_PSI_DEFAULT_DISABLED=y

Hyper-V Dynamic Memory settings:
- Startup RAM: 1024 MB
- Minimum RAM: 512 MB
- Maximum RAM: 16384 MB

auto_online_blocks: Set to online manually after discovering the
default was offline

PSI: Enabled via psi=1 kernel parameter after discovering
CONFIG_PSI_DEFAULT_DISABLED=y

Driver module parameters verified on test system:
- /sys/module/hv_balloon/parameters/hot_add = Y (hot-add enabled)
- /sys/module/hv_balloon/parameters/pressure_report_delay = 0 (no startup delay)


3. USE CASE: VS CODE REMOTE SSH WITH DEVCONTAINER

This use case is representative of a class of developer workloads with
containerized development environments, that are increasingly common
on Linux VMs hosted on Hyper-V.

Workload profile:
VS Code Remote SSH connects to the Alpine guest and starts a Home
Assistant Add-on development container (ha-dev). The VS Code server
process (node) expands from zero to approximately 240 MB RSS within 10
seconds of connection. Multiple node processes spawn in rapid
succession as extensions and language servers load.

Expected behavior:
Hyper-V Dynamic Memory detects guest memory pressure, initiates
hot-add to expand MemTotal beyond the startup value, guest makes the
new memory available via auto_online_blocks, workload proceeds
normally.

Observed behavior:
MemTotal remained at 921764 kB (startup RAM) throughout the entire
session. dmesg showed no hot-add activity whatsoever. The system
responded by swapping aggressively and reaching PSI avg10 values of
97% before becoming unresponsive.


4. MEASUREMENT DATA

All measurements were collected using a custom shell script sampling
/proc/pressure/memory, /proc/vmstat and /proc/meminfo at 1-2 second
intervals, with per-process RSS from /proc/PID/status.

Timeline of VS Code startup of remote containers (elapsed time from connection)

Time    Event                               PSI delta/s      Swap
pages out   MemTotal
+0s     Baseline, docker running            0 us             0
       921764 kB
+48s    VS Code server appears              0 us             0
       921764 kB
+50s    node 107 MB RSS                     152,837 us       3,748
       921764 kB
+55s    4 node processes, 348 MB RSS total  941,966 us       22,945
       921764 kB
+92s    PSI avg10 48%                       6,357,506 us     159,934
       921764 kB
+106s   PSI avg10 83%                       13,446,517 us    160,262
       921764 kB
+179s   PSI avg10 97%                       20,093,449 us    165,208
       921764 kB

Key observations:
- MemTotal never changed from startup value
- No hot-add lines appeared in dmesg at any point during or after the session
- PSI cumulative stall since boot at session end: 804,383,983
microseconds (804 seconds of accumulated memory stall)


5. ROOT CAUSE ANALYSIS

The fundamental design gap in hv_balloon is the complete absence of
burst demand support. The driver was designed around a polling-based,
fixed-interval model and has no mechanism to detect or respond to
rapid memory transitions. All other issues described below are
consequences or amplifications of this core architectural limitation.

Issue 1: No burst demand support in the driver architecture

The driver has no concept of burst demand, a rapid transition from low
memory pressure to near-OOM within seconds. There is no fast path, no
threshold trigger, and no priority escalation mechanism. The entire
communication model between guest and host is based on periodic status
reporting, which by design introduces latency that is structurally
incompatible with burst workloads. A guest can transition from 0% to
97% PSI memory stall and write 160,000 swap pages before the driver
has sent more than a handful of status messages to the host.

Modern workloads such as containerized development environments,
Kubernetes pod scheduling, JVM heap initialization, Node.js extension
loading, routinely demand hundreds of megabytes of memory within a
5-10 second window. The driver architecture predates this workload
class entirely.

Issue 2: 1-second fixed-interval polling loop is too slow for burst workloads

The hv_balloon thread reports memory pressure to the host once per
second via post_status(). Source:
elixir.bootlin.com/linux/v6.14.6/source/drivers/hv/hv_balloon.c#L1381
(verified via Medium article by Shlomi Boutnaru, May 2025).

VS Code expanded from 0 to 240 MB RSS in under 10 seconds. By the time
the host received sufficient pressure signals to consider a hot-add
response, the guest had already exhausted available memory and entered
heavy swap. The polling cadence has no mechanism to accelerate or
escalate regardless of how severe or rapid the memory pressure
becomes.

Issue 3: pressure_report_delay not a factor in this case

The hv_balloon module parameter pressure_report_delay defaults to 30
seconds per the original 2013 patch. Source: K.Y. Srinivasan, [PATCH
1/2] Drivers: hv: balloon: Add a parameter to delay pressure
reporting, lkml.indiana.edu, 2013. On the test system this parameter
was verified to be 0
(/sys/module/hv_balloon/parameters/pressure_report_delay = 0), meaning
pressure reporting was not delayed. This eliminates
pressure_report_delay as a contributing factor in this specific case
and strengthens the conclusion that Issues 1 and 2 are solely
responsible for the observed failure.

Note: on systems where pressure_report_delay retains its default value
of 30, the failure window would be significantly wider, as the host
would receive no pressure data at all during the first 30 seconds
after driver load.

Issue 4: Sequential hot-add protocol prevents parallel responses

Per the Hyper-V Dynamic Memory protocol specification: the host must
not send a new hot-add request until the guest has responded to the
previous one. Source: quoted in QEMU developer discussion,
mail-archive.com, September 2020. Combined with the 128 MB minimum
DIMM size for Linux hot-add (source: patchew.org, verified search
result), each expansion step is large, slow and serialized.

Issue 5: MHP_DEFAULT_ONLINE_TYPE_OFFLINE leaves hot-added memory unusable

Alpine Linux ships with CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE=y.
Hot-added memory sections are registered in sysfs but remain in
offline state until explicitly brought online. Without udev (Alpine
uses mdev) there is no automatic mechanism to online new sections. The
auto_online_blocks sysfs interface defaults to offline and must be
manually set to online.

This issue was identified and resolved in this specific environment by
setting echo online > /sys/devices/system/memory/auto_online_blocks
and making it persistent via /etc/local.d/memory-hotplug.start.
However even with this fix applied, hot-add was never triggered by the
host during the VS Code session. This confirms that Issues 1-4 are the
primary blockers and Issue 5 is a prerequisite that was already
satisfied.


6. COMPARISON WITH KNOWN SIMILAR REPORTS AND RECENT PATCHES

This failure mode is not new. A Kubernetes/minikube issue from 2017
describes an identical pattern: memory demand increases, Hyper-V
Manager shows warning status, assigned memory never increases, OOM
killer activates. Source: github.com/kubernetes/minikube/issues/1403.
The issue was closed as stale without resolution. The present report
provides significantly more detailed measurement data and kernel
configuration context than the prior report.

The driver is actively maintained. Two recent patches are relevant as context:

- A March 2024 patch by Michael Kelley fixes hot-add failures on
systems with memblock sizes larger than 128 MB, where add_memory()
would fail with error -22. Source: lore.kernel.org/lkml, March 2024.
This is a separate correctness fix and does not address burst demand.
- A January 2025 patch accepted into hyperv-next fixes an issue where
the balloon driver's global page-onlining callback blocked hot-add of
memory from GPU and vPCI device drivers. Source:
mail-archive.com/linux-hyperv, January 2025. Again a separate
correctness fix, but both patches confirm the driver is under active
development and that the maintainers are responsive to bug reports.

No open patches or RFC discussions on linux-hyperv@vger.kernel.org
addressing burst demand or PSI integration in hv_balloon were
identified as of April 2026.


7. PROPOSED IMPROVEMENTS

RFE 1: PSI-triggered hot-add requests to handle burst demand

The driver's current architecture is built around fixed-interval
polling: it reports memory pressure to the host once per second via
post_status() and waits for the host to initiate a hot-add sequence.
This design has no mechanism to accelerate or escalate outside the
polling cadence regardless of how severe or rapid the memory pressure
becomes.

Modern workloads have fundamentally different memory characteristics.
Containers, container runtimes (Docker, containerd, podman), JVM-based
systems, Node.js applications, Kubernetes pods, and development
environments such as VS Code devcontainers routinely exhibit burst
demand patterns: a guest transitions from low memory pressure to
near-OOM within seconds as processes spawn, images are pulled, or
runtimes initialize their heaps. Kubernetes is a particularly
illustrative case - the entire value proposition of dynamic memory
allocation in a Kubernetes node depends on the hypervisor being able
to supply memory fast enough to honor pod scheduling decisions. When a
scheduler assigns a new pod to a node, it expects memory to be
available within seconds, not after a multi-second feedback loop that
may itself be preceded by a 30-second pressure_report_delay. This
pattern is not an edge case - it is the normal startup behavior of a
significant proportion of workloads running on Linux VMs today.

The VS Code devcontainer use case presented in this report is
representative but not exceptional. Any workload that combines a
container runtime with a language server, a build system, a database
startup sequence, or a Kubernetes pod scheduling event will exhibit
similar burst demand characteristics. The 1-second fixed-interval
polling loop is structurally incapable of protecting against this
class of memory event regardless of host configuration.

The infrastructure to solve this already exists in the Linux kernel.
PSI threshold triggers via poll() on /proc/pressure/memory have been
available since kernel 4.20 and are already used by systemd-oomd and
Facebook's oomd to react to memory pressure faster than periodic
polling allows. The driver should leverage this same mechanism to send
an immediate out-of-band hot-add request to the host when burst demand
is detected, specifically when memory.full exceeds a configurable
threshold such as 10% over a 500ms window. This would allow the host
to begin the hot-add sequence at the onset of burst demand rather than
after the guest has already entered heavy swap.

This improvement requires no protocol-level changes if the existing
hot-add request message is used as the signal. A protocol extension
adding an explicit "burst demand" flag to the status message would be
preferable, allowing the host to prioritize the response and bypass
any queuing of normal pressure-based adjustments.

RFE 2: Document auto_online_blocks requirement

The kernel documentation and Hyper-V guest integration documentation
should explicitly state that auto_online_blocks must be set to online
(or the kernel compiled with MHP_DEFAULT_ONLINE_TYPE_ONLINE_AUTO) for
Dynamic Memory hot-add to function on distributions that do not use
udev with a memory hotplug rule. Currently this is undocumented and
discoverable only by reading kernel source or community bug reports.

RFE 3: Diagnostics when hot-add is not triggered

When PSI memory.full avg10 exceeds a significant threshold (e.g. 10%)
without a hot-add request being sent or received, the driver should
emit a pr_warn to dmesg. Currently the guest has no visibility into
whether the host is aware of pressure, whether a hot-add request was
sent, or whether it failed. This makes the failure mode completely
silent from the guest's perspective.

RFE 4: Consider proactive pressure signaling

The driver could be extended to send an out-of-band high-priority
pressure signal to the host when PSI crosses a critical threshold,
rather than waiting for the next 1-second polling cycle. This would
require a protocol-level change and coordination with the Hyper-V host
implementation but would address the fundamental latency issue.


8. WHAT IS UNKNOWN

Why the host never sent a hot-add request despite the guest reaching
near-OOM conditions is unknown. The host-side decision algorithm for
when to initiate hot-add is proprietary and not publicly documented.
It is possible the host's memory pressure thresholds were not met
because guest-side pressure reporting was too slow to accumulate
sufficient signal. It is also possible the host's algorithm is simply
not designed for burst workloads of this type.

The Hyper-V Dynamic Memory Buffer setting (configurable between 5% and
200%, default 20%) controls how much headroom the host maintains above
current demand. Whether increasing this value would provide sufficient
buffer to absorb burst demand without requiring hot-add at all is
unknown without testing. It would not address the architectural
limitation but could serve as a partial operational mitigation.
--

