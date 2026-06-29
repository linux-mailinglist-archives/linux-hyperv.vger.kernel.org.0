Return-Path: <linux-hyperv+bounces-11694-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LDq2GmgLQmpizQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11694-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:06:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 206AE6D6272
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 08:06:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rQOhue7e;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rQOhue7e;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11694-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11694-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 628C5301A161
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 06:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185873955E2;
	Mon, 29 Jun 2026 06:05:39 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AA2F5A29
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jun 2026 06:05:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713139; cv=none; b=OyznqnEwE8iaRbbAZeGR1/yfoqnqoquUhK2DrjPkP/VaSX8CVf9FdDVY+r3h3zKMJoNFuNX10tQVkubWWHPveErtk9YLudkW8pezArYn0YveF1xUsG4DFeVlfWrioYNog/4K12sylATK6pwre6M/m8ef4sx65AOj4P7v6nRYF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713139; c=relaxed/simple;
	bh=DarU8t3M1Fz7v5BFTrpcbT6v8AODn3pnviXSxdolNEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8wjamk6KNS/q/qMylm9FhTVXPUtvPLoKbM66DhLjTW1nMwpjP6Te6uCdT/Ik2GuNbtUh7OBuGv2yblWiBFHDeTrga7exRE+AC0fqyoM6S3SvYpCuimwL9cOMzydTDYFOeDYlLLkdX9UIJKM8eUZ+DgKbZEzB9Epo5mbJIUm/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rQOhue7e; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rQOhue7e; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B3FE75D0F;
	Mon, 29 Jun 2026 06:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ucXwQadpGPBgriEK86cLgPUeZrADzv4dSH5gZLBm9SU=;
	b=rQOhue7eG1RqOZRWiTw8jbCuylMHgYcRVVXmqtOaxabAsUR6H290EGbG1g90SBE8kfAqwf
	xu2wV5hF+XiJ5Gzn226V2je0ZU54Dy6cNLbgR6f3rixfzMkKJrxVD78cfU42kZcGy4TTPt
	MteQ3NP7j5ZUp3ss3go9PMVdq5ajvlo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ucXwQadpGPBgriEK86cLgPUeZrADzv4dSH5gZLBm9SU=;
	b=rQOhue7eG1RqOZRWiTw8jbCuylMHgYcRVVXmqtOaxabAsUR6H290EGbG1g90SBE8kfAqwf
	xu2wV5hF+XiJ5Gzn226V2je0ZU54Dy6cNLbgR6f3rixfzMkKJrxVD78cfU42kZcGy4TTPt
	MteQ3NP7j5ZUp3ss3go9PMVdq5ajvlo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0872E779A8;
	Mon, 29 Jun 2026 06:05:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JTiaACoLQmotEQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:05:30 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-edac@vger.kernel.org,
	x86@kernel.org,
	linux-acpi@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-ide@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	platform-driver-x86@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jason Baron <jbaron@akamai.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Pu Wen <puwen@hygon.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	David Airlie <airlied@redhat.com>,
	Helge Deller <deller@gmx.de>,
	linux-geode@lists.infradead.org,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ashok Raj <ashok.raj.linux@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 00/32] x86/msr: Drop 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:04:51 +0200
Message-ID: <20260629060526.3638272-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,intel.com,arm.com,akamai.com,alien8.de,amd.com,redhat.com,linux.intel.com,zytor.com,google.com,hygon.cn,broadcom.com,linaro.org,zhaoxin.com,gmx.de,lists.infradead.org,selenic.com,gondor.apana.org.au,arndb.de,linuxfoundation.org,microsoft.com,roeck-us.net,infradead.org,oracle.com,gmail.com,bootlin.com,nod.at,ti.com,lists.xenproject.org];
	TAGGED_FROM(0.00)[bounces-11694-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-edac@vger.kernel.org,m:x86@kernel.org,m:linux-acpi@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-pci@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-ide@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fbdev@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:platform-driver-x86@vger.kernel.org,m:jgross@suse.com,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:rui.zhang@intel.com,m:lukasz.luba@arm.com,m:jbaron@akamai.com,m:bp@alien8.de,m:tony.luck@intel.com,m:yazen.ghannam@amd.com,m:lenb@kernel.org,m:pavel@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:seanjc@google.com,m:pbonzini@redhat.com,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:puwen@hyg
 on.cn,m:bhelgaas@google.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:viresh.kumar@linaro.org,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:TonyWWang-oc@zhaoxin.com,m:dlemoal@kernel.org,m:cassel@kernel.org,m:airlied@redhat.com,m:deller@gmx.de,m:linux-geode@lists.infradead.org,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:linusw@kernel.org,m:brgl@kernel.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux@roeck-us.net,m:peterz@infradead.org,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:jpoimboe@kernel.org,m:pawan.kumar.gupta@linux.intel.com,m:vkuznets@redhat.com,m:luto@kernel.org,m:boris.ostrovsky@oracle.com,m:ray.h
 uang@amd.com,m:mario.limonciello@amd.com,m:perry.yuan@amd.com,m:kprateek.nayak@amd.com,m:srinivas.pandruvada@linux.intel.com,m:artem.bityutskiy@linux.intel.com,m:dedekind1@gmail.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:ashok.raj.linux@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:irenic.rajneesh@gmail.com,m:david.e.box@intel.com,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_GT_50(0.00)[96];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 206AE6D6272

For accessing the MSR registers on the local CPU, there are 2 types of
interfaces: the "modern" 64-bit ones (rdmsrq() etc.) and the 32-bit
ones (rdmsr() etc.) which are using the upper and lower 32-bit halves
of the 64-bit wide MSR register values.

The 32-bit interfaces are not optimal for 3 reasons:

- They are based on primitives using 64-bit sized values anyway.

- Modern x86 CPUs have added support for MSR access instructions using
  an immediate value instead of a register for addressing the MSR,
  while the value is in a 64-bit register.

- rdmsr() is a macro storing the upper and lower 32-bit halves in
  variables specified as macro parameters. This is obscuring variable
  assignment through a macro. Additionally rdmsrq() is mimicking this
  pattern by being a macro, too, with the target variable specified as
  a parameter as well.

For those reasons drop the 32-bit interfaces for accessing the x86 MSR
registers completely and only use the 64-bit variants.

This allows to switch all "high-level" MSR access macros to inline
functions in the end.

This series will be used as the base for further reorganisation of the
MSR access functions, especially for completely inlining the MSR
access instructions even with paravirtualization being active.

Note that most patches of this series are independent from each other.
Only the patches removing a specific interface (patches 7, 15, 26 and
30) and the last two patches of the series depend on all previous
patches.

Based on kernel 7.2-rc1, tested with and without parvirtualization
active, compile tested for x86 with 64- and 32-bit allyes and allno
configs.

Juergen Gross (32):
  thermal/intel: Stop using 32-bit MSR interfaces
  powercap: Stop using 32-bit MSR interfaces
  edac: Stop using 32-bit MSR interfaces
  acpi: Stop using 32-bit MSR interfaces
  x86/mtrr: Stop using 32-bit MSR interfaces
  x86/msr: Stop using 32-bit MSR interfaces in lib/msr-smp.c
  x86/msr: Remove wrmsr_safe()
  x86/mce: Stop using 32-bit MSR interfaces
  KVM/x86: Stop using 32-bit MSR interfaces
  x86/hygon: Stop using 32-bit MSR interfaces
  x86/pci: Stop using 32-bit MSR interfaces
  x86/amd: Stop using 32-bit MSR interfaces
  x86/featctl: Stop using 32-bit MSR interfaces
  x86/tsc: Stop using 32-bit MSR interfaces
  x86/msr: Remove rdmsr_safe()
  cpufreq: Stop using 32-bit MSR interfaces
  x86/resctrl: Stop using 32-bit MSR interfaces
  x86/apic: Stop using 32-bit MSR interfaces
  x86/cpu: Stop using 32-bit MSR interfaces
  drivers/ata: Stop using 32-bit MSR interfaces
  agp/nvidia: Stop using 32-bit MSR interfaces
  fbdev/geode: Stop using 32-bit MSR interfaces
  hw_random/via-rng: Stop using 32-bit MSR interfaces
  drivers/gpio: Stop using 32-bit MSR interfaces
  drivers/misc: Stop using 32-bit MSR interfaces
  x86/msr: Remove wrmsr()
  x86/hyperv: Stop using 32-bit MSR interfaces
  x86/olpc: Stop using 32-bit MSR interfaces
  hwmon: Stop using 32-bit MSR interfaces
  x86/msr: Remove rdmsr()
  treewide: convert rdmsrq() from a macro to an inline function
  x86/msr: Simplify some rdmsrq() use cases

 arch/x86/coco/sev/core.c                      |  2 +-
 arch/x86/events/amd/brs.c                     |  4 +-
 arch/x86/events/amd/core.c                    |  8 +-
 arch/x86/events/amd/ibs.c                     | 18 ++--
 arch/x86/events/amd/lbr.c                     | 16 +--
 arch/x86/events/amd/power.c                   |  8 +-
 arch/x86/events/amd/uncore.c                  |  4 +-
 arch/x86/events/core.c                        | 20 ++--
 arch/x86/events/intel/core.c                  | 14 +--
 arch/x86/events/intel/cstate.c                |  5 +-
 arch/x86/events/intel/ds.c                    |  2 +-
 arch/x86/events/intel/knc.c                   | 10 +-
 arch/x86/events/intel/lbr.c                   | 25 ++---
 arch/x86/events/intel/p4.c                    |  6 +-
 arch/x86/events/intel/p6.c                    |  4 +-
 arch/x86/events/intel/pt.c                    | 12 +--
 arch/x86/events/intel/uncore.c                |  6 +-
 arch/x86/events/intel/uncore_nhmex.c          |  4 +-
 arch/x86/events/intel/uncore_snb.c            |  2 +-
 arch/x86/events/intel/uncore_snbep.c          |  6 +-
 arch/x86/events/msr.c                         |  2 +-
 arch/x86/events/perf_event.h                  |  6 +-
 arch/x86/events/rapl.c                        |  6 +-
 arch/x86/events/zhaoxin/core.c                | 10 +-
 arch/x86/hyperv/hv_apic.c                     | 17 ++--
 arch/x86/hyperv/hv_init.c                     | 26 ++---
 arch/x86/hyperv/hv_spinlock.c                 |  2 +-
 arch/x86/include/asm/apic.h                   |  7 +-
 arch/x86/include/asm/debugreg.h               |  6 +-
 arch/x86/include/asm/fsgsbase.h               |  2 +-
 arch/x86/include/asm/kvm_host.h               |  5 +-
 arch/x86/include/asm/msr.h                    | 39 +-------
 arch/x86/include/asm/paravirt.h               | 26 +----
 arch/x86/include/asm/resctrl.h                |  5 +-
 arch/x86/kernel/acpi/sleep.c                  | 20 ++--
 arch/x86/kernel/apic/apic.c                   | 45 ++++-----
 arch/x86/kernel/apic/apic_numachip.c          |  6 +-
 arch/x86/kernel/cet.c                         |  2 +-
 arch/x86/kernel/cpu/amd.c                     | 42 ++++----
 arch/x86/kernel/cpu/aperfmperf.c              |  8 +-
 arch/x86/kernel/cpu/bugs.c                    | 12 +--
 arch/x86/kernel/cpu/bus_lock.c                |  8 +-
 arch/x86/kernel/cpu/centaur.c                 | 35 +++----
 arch/x86/kernel/cpu/common.c                  | 22 +++--
 arch/x86/kernel/cpu/feat_ctl.c                | 27 +++---
 arch/x86/kernel/cpu/hygon.c                   |  9 +-
 arch/x86/kernel/cpu/intel.c                   | 12 +--
 arch/x86/kernel/cpu/intel_epb.c               |  4 +-
 arch/x86/kernel/cpu/mce/amd.c                 | 89 ++++++++---------
 arch/x86/kernel/cpu/mce/core.c                | 10 +-
 arch/x86/kernel/cpu/mce/inject.c              |  2 +-
 arch/x86/kernel/cpu/mce/intel.c               | 18 ++--
 arch/x86/kernel/cpu/mce/p5.c                  | 16 +--
 arch/x86/kernel/cpu/mce/winchip.c             | 10 +-
 arch/x86/kernel/cpu/microcode/intel.c         |  2 +-
 arch/x86/kernel/cpu/mshyperv.c                |  6 +-
 arch/x86/kernel/cpu/mtrr/amd.c                | 36 ++++---
 arch/x86/kernel/cpu/mtrr/centaur.c            | 18 ++--
 arch/x86/kernel/cpu/mtrr/cleanup.c            | 18 ++--
 arch/x86/kernel/cpu/mtrr/generic.c            | 97 ++++++++++---------
 arch/x86/kernel/cpu/mtrr/mtrr.c               |  4 +-
 arch/x86/kernel/cpu/resctrl/core.c            |  9 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         | 27 +++---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     | 12 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |  2 +-
 arch/x86/kernel/cpu/topology.c                |  2 +-
 arch/x86/kernel/cpu/topology_amd.c            |  4 +-
 arch/x86/kernel/cpu/transmeta.c               |  9 +-
 arch/x86/kernel/cpu/tsx.c                     | 10 +-
 arch/x86/kernel/cpu/umwait.c                  |  2 +-
 arch/x86/kernel/cpu/zhaoxin.c                 | 12 +--
 arch/x86/kernel/fpu/core.c                    |  2 +-
 arch/x86/kernel/hpet.c                        |  2 +-
 arch/x86/kernel/kvm.c                         |  2 +-
 arch/x86/kernel/mmconf-fam10h_64.c            |  6 +-
 arch/x86/kernel/process.c                     |  4 +-
 arch/x86/kernel/process_64.c                  | 14 +--
 arch/x86/kernel/shstk.c                       |  8 +-
 arch/x86/kernel/traps.c                       |  4 +-
 arch/x86/kernel/tsc.c                         |  8 +-
 arch/x86/kernel/tsc_msr.c                     | 15 +--
 arch/x86/kernel/tsc_sync.c                    |  6 +-
 arch/x86/kvm/svm/pmu.c                        |  4 +-
 arch/x86/kvm/svm/svm.c                        |  4 +-
 arch/x86/kvm/vmx/nested.c                     |  4 +-
 arch/x86/kvm/vmx/pmu_intel.c                  |  8 +-
 arch/x86/kvm/vmx/sgx.c                        |  6 +-
 arch/x86/kvm/vmx/vmx.c                        | 54 ++++++-----
 arch/x86/kvm/x86.c                            | 12 +--
 arch/x86/lib/insn-eval.c                      |  6 +-
 arch/x86/lib/msr-smp.c                        |  8 +-
 arch/x86/mm/pat/memtype.c                     |  2 +-
 arch/x86/pci/amd_bus.c                        |  8 +-
 arch/x86/pci/mmconfig-shared.c                |  8 +-
 arch/x86/platform/olpc/olpc-xo1-rtc.c         |  6 +-
 arch/x86/platform/olpc/olpc-xo1-sci.c         | 11 ++-
 arch/x86/power/cpu.c                          | 10 +-
 arch/x86/realmode/init.c                      |  2 +-
 arch/x86/virt/hw.c                            |  8 +-
 arch/x86/virt/svm/sev.c                       | 18 ++--
 arch/x86/virt/vmx/tdx/tdx.c                   |  8 +-
 arch/x86/xen/suspend.c                        |  2 +-
 drivers/acpi/processor_perflib.c              | 11 ++-
 drivers/acpi/processor_throttling.c           | 14 +--
 drivers/ata/pata_cs5535.c                     | 20 ++--
 drivers/ata/pata_cs5536.c                     | 17 ++--
 drivers/char/agp/nvidia-agp.c                 | 32 +++---
 drivers/char/hw_random/via-rng.c              | 29 +++---
 drivers/cpufreq/acpi-cpufreq.c                | 24 ++---
 drivers/cpufreq/amd-pstate.c                  |  4 +-
 drivers/cpufreq/e_powersaver.c                | 52 +++++-----
 drivers/cpufreq/intel_pstate.c                | 30 +++---
 drivers/cpufreq/longhaul.c                    | 23 ++---
 drivers/cpufreq/longrun.c                     | 78 ++++++++-------
 drivers/cpufreq/powernow-k6.c                 | 12 +--
 drivers/cpufreq/powernow-k7.c                 | 10 +-
 drivers/cpufreq/powernow-k8.c                 | 67 ++++++-------
 drivers/cpufreq/speedstep-centrino.c          | 16 +--
 drivers/cpufreq/speedstep-lib.c               | 63 ++++++------
 drivers/edac/amd64_edac.c                     |  6 +-
 drivers/edac/ie31200_edac.c                   | 10 +-
 drivers/edac/mce_amd.c                        |  8 +-
 drivers/gpio/gpio-cs5535.c                    | 10 +-
 drivers/hv/mshv_vtl_main.c                    |  2 +-
 drivers/hwmon/hwmon-vid.c                     | 11 ++-
 drivers/idle/intel_idle.c                     | 26 ++---
 drivers/misc/cs5535-mfgpt.c                   | 33 +++----
 drivers/mtd/nand/raw/cs553x_nand.c            |  6 +-
 drivers/platform/x86/intel/ifs/load.c         | 10 +-
 drivers/platform/x86/intel/ifs/runtest.c      |  8 +-
 drivers/platform/x86/intel/pmc/cnp.c          |  2 +-
 .../intel/speed_select_if/isst_if_mbox_msr.c  |  6 +-
 .../intel/speed_select_if/isst_tpmi_core.c    |  2 +-
 drivers/platform/x86/intel_ips.c              | 20 ++--
 drivers/powercap/intel_rapl_common.c          | 20 ++--
 drivers/powercap/intel_rapl_msr.c             |  2 +-
 drivers/thermal/intel/intel_hfi.c             |  8 +-
 drivers/thermal/intel/intel_tcc.c             | 10 +-
 drivers/thermal/intel/therm_throt.c           | 74 +++++++-------
 drivers/thermal/intel/x86_pkg_temp_thermal.c  | 32 +++---
 drivers/video/fbdev/geode/display_gx.c        |  8 +-
 drivers/video/fbdev/geode/gxfb_core.c         |  2 +-
 drivers/video/fbdev/geode/lxfb_ops.c          | 50 +++++-----
 drivers/video/fbdev/geode/suspend_gx.c        | 24 ++---
 drivers/video/fbdev/geode/video_gx.c          |  8 +-
 include/linux/cs5535.h                        | 10 +-
 146 files changed, 1044 insertions(+), 1128 deletions(-)

-- 
2.54.0


