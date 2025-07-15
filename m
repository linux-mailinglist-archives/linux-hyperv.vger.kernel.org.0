Return-Path: <linux-hyperv+bounces-6243-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B2B04D07
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 02:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083134A0F25
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 00:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FCD13D521;
	Tue, 15 Jul 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/ij6bxq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AD1553A3
	for <linux-hyperv@vger.kernel.org>; Tue, 15 Jul 2025 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539969; cv=none; b=hznAaH6C2TUrqkMt8xZdxtu4xQtnorP6dHULsfy+pQkRHZEYO2fbmLYTLuukez5aYWhzAOy/HtgfW/7ljNP1PKaXesCjD6xXLxHfaGA5O/Wnyv5b4LsOZPXe7/jyZPY3k/+UwzLPVwBPk5RWSJUSma03mwqoKG1xv+d9Lcy8yZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539969; c=relaxed/simple;
	bh=SZ+ako+Md6V3DmitMn3KsodeFoTVI/klO+48PAiJDpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxTK4a/y560Cvu5YFz7WcrTSXRMSQQi8hZVhmUSCBJZb0gjcncgKgUyMVqvxZK+rm7QjeLe0sbiWnhYPxejjwRdpOA6ksiJAUTF6YC8bMltcEA9abfzbxZy/cVj5AZ11qPY8UEpNr9IJH4F/n6sl0BV2vO+bW5k+r3wMxQM58YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/ij6bxq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3928ad6176so4427174a12.3
        for <linux-hyperv@vger.kernel.org>; Mon, 14 Jul 2025 17:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752539967; x=1753144767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckvgkztw5PsR0nrJW0AaWbazC5ZmdDbzOlFi73gHwFY=;
        b=S/ij6bxq07KyvhGKsR8LJmNopXoaSeC4XjTLMxOu0OzGsAv68GLjm2+5+zBzkWLtZn
         6bv94T7ICSdV6yg/fwSSs9vtW7teySa+6fbZlzcSjM/0xyF8EjhvrEaEt3oQJnqMtEha
         gl19eW7/E9RqY+z1dCLiRcdMXfgFazwJE+xzMiyxVZz/pWxGn9Yhig2KbkG2UINw4dOE
         rDPzz0ZyljWWsT0GNIS2tG4tkK9gvmVvYWDGHuVSKAkaZKM4JRHQOH4hpoRnXtrN3yNo
         VTHS9gqSbkGL7GhDvfK1TaR32JFBTedSyJYb7VjjxLDPm6mtGwBao2aou/3OmZGzQFJW
         vdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752539967; x=1753144767;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckvgkztw5PsR0nrJW0AaWbazC5ZmdDbzOlFi73gHwFY=;
        b=w9FZTUOAVIsDY1gkR8/z1bsHHK2kavwjJb9Qrh+E048O/9nZcHk6+c173i9M3C82HS
         phgJKuIICVC5UZDIhLRFfDchc4SKXPBa5VKxHww0QaBvx8xOC3NZppCDibJKfojOWSpx
         7n38yXU7Hi5M6AkPps6pvTX1MH7wHzxThVIrPwqwBsO4deMJNG36wP1VNgAyvQsWmGh5
         FrVXvH6qj5uPktv6NNbRteDf8JL6hQAneRUaco3IL0lHZvNdCoJwhKiUTYoClMvttgei
         bGdQ5ONmn0/+XAxnxcRAVqGgycprxkyZjwcjEervL3uolw+EXzpbiDQFCjJNfTAqPEAF
         gMRg==
X-Forwarded-Encrypted: i=1; AJvYcCU8wvLEdOXQZY11xwoMffY05Dz1U8NgBKwTWjw24to/40MP8QvQy6dIytIlQip45NElkqscs0DMe7M4AJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdvmqLZOgnhZd/ozwxkQW1XVDn9naZf2Ir6P9ZBaUoVgUnjL1U
	yyhXelsUqN9l3eVVUwrxcsEsM81L8kddudgZ4alzbZhzElV+OmbnOgkHWFey86lq+cuP5MJ1vWj
	Abljthg==
X-Google-Smtp-Source: AGHT+IFTKeboxMBeGguF7GWa2Og0RV2Q3w2SRSWGsp9FUhWgJFz+qbsRa/1nhK14F1KmTA+K1KVR+HUj9fw=
X-Received: from pfay34.prod.google.com ([2002:a05:6a00:1822:b0:748:ed01:df48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748b:b0:235:3eaf:8979
 with SMTP id adf61e73a8af0-2353eaf8995mr8615192637.15.1752539967153; Mon, 14
 Jul 2025 17:39:27 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:39:25 -0700
In-Reply-To: <87o6tttliq.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1750432368.git.jpiotrowski@linux.microsoft.com>
 <4266fc8f76c152a3ffcbb2d2ebafd608aa0fb949.1750432368.git.jpiotrowski@linux.microsoft.com>
 <875xghoaac.fsf@redhat.com> <ca26fba1-c2bb-40a1-bb5e-92811c4a6fc6@linux.microsoft.com>
 <87o6tttliq.fsf@redhat.com>
Message-ID: <aHWjPSIdp5B-2UBl@google.com>
Subject: Re: [RFC PATCH 1/1] KVM: VMX: Use Hyper-V EPT flush for local TLB flushes
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	alanjiang@microsoft.com, chinang.ma@microsoft.com, 
	andrea.pellegrini@microsoft.com, Kevin Tian <kevin.tian@intel.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Vitaly Kuznetsov wrote:
> Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> writes:
> 
> > On 27/06/2025 10:31, Vitaly Kuznetsov wrote:
> >> Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> writes:
> >> 
> >>> Use Hyper-V's HvCallFlushGuestPhysicalAddressSpace for local TLB flushes.
> >>> This makes any KVM_REQ_TLB_FLUSH_CURRENT (such as on root alloc) visible to
> >>> all CPUs which means we no longer need to do a KVM_REQ_TLB_FLUSH on CPU
> >>> migration.
> >>>
> >>> The goal is to avoid invept-global in KVM_REQ_TLB_FLUSH. Hyper-V uses a
> >>> shadow page table for the nested hypervisor (KVM) and has to invalidate all
> >>> EPT roots when invept-global is issued.

What all does "invalidate" mean here?  E.g. is this "just" a hardware TLB flush,
or is Hyper-V blasting away and rebuilding page tables?  If it's the latter, that
seems like a Hyper-V bug/problem.

> >>> This has a performance impact on all nested VMs.  KVM issues
> >>> KVM_REQ_TLB_FLUSH on CPU migration, and under load the performance hit
> >>> causes vCPUs to use up more of their slice of CPU time, leading to more
> >>> CPU migrations. This has a snowball effect and causes CPU usage spikes.

Is the performance hit due to flushing *hardware* TLBs, or due to Hyper-V needing
to rebuilding shadow page tables?

> >>> By issuing the hypercall we are now guaranteed that any root modification
> >>> that requires a local TLB flush becomes visible to all CPUs. The same
> >>> hypercall is already used in kvm_arch_flush_remote_tlbs and
> >>> kvm_arch_flush_remote_tlbs_range.  The KVM expectation is that roots are
> >>> flushed locally on alloc and we achieve consistency on migration by
> >>> flushing all roots - the new behavior of achieving consistency on alloc on
> >>> Hyper-V is a superset of the expected guarantees. This makes the
> >>> KVM_REQ_TLB_FLUSH on CPU migration no longer necessary on Hyper-V.
> >> 
> >> Sounds reasonable overall, my only concern (not sure if valid or not) is
> >> that using the hypercall for local flushes is going to be more expensive
> >> than invept-context we do today and thus while the performance is
> >> improved for the scenario when vCPUs are migrating a lot, we will take a
> >> hit in other cases.
> >> 
> >
> 
> Sorry for delayed reply!
> 
> ....
> 
> >>>  		return;
> >>>  
> >>> -	if (enable_ept)
> >>> +	if (enable_ept) {
> >>> +		/*
> >>> +		 * hyperv_flush_guest_mapping() has the semantics of
> >>> +		 * invept-single across all pCPUs. This makes root
> >>> +		 * modifications consistent across pCPUs, so an invept-global
> >>> +		 * on migration is no longer required.

Unfortunately, this isn't quite right.  If vCPU0 and vCPU1 share an EPT root,
APIC virtualization is enabled, and vCPU0 is running with x2APIC but vCPU1 is
running with xAPIC, then KVM needs to flush TLBs if vCPU1 is loaded on a "new"
pCPU, because vCPU0 could have inserted non-vAPIC TLB entries for that pCPU.

Hrm, but KVM doesn't actually handle that properly.  KVM only forces a TLB flush
if the vCPU wasn't already loaded, so if vCPU0 and vCPU1 are running on the same
pCPU, i.e. vCPU1 isn't being migrated to the pCPU that was previously running
vCPU0, then I believe vCPU1 could consume stale TLB entries.

Setting that aside for the moment, I would much prefer to elide this TLB flush
whenver possible, irrespective of whether KVM is running on bare metal or in a
VM, and irrespective of the host hypervisor.  And then if/when SVM is converted
to use per-vCPU ASIDs[*], give SVM the exact same treatment.  More below.

[*] https://lore.kernel.org/all/aFXrFKvZcJ3dN4k_@google.com

> >> HvCallFlushGuestPhysicalAddressSpace sounds like a heavy operation as it
> >> affects all processors. Is there any visible perfomance impact of this
> >> change when there are no migrations (e.g. with vCPU pinning)? Or do we
> >> believe that Hyper-V actually handles invept-context the exact same way?
> >> 
> > I'm going to have to do some more investigation to answer that - do you have an
> > idea of a workload that would be sensitive to tlb flushes that I could compare
> > this on?
> >
> > In terms of cost, Hyper-V needs to invalidate the VMs shadow page table for a root
> > and do the tlb flush. The first part is CPU intensive but is the same in both cases
> > (hypercall and invept-single). The tlb flush part will require a bit more work for
> > the hypercall as it needs to happen on all cores, and the tlb will now be empty
> > for that root.
> >
> > My assumption is that these local tlb flushes are rather rare as they will
> > only happen when:
> > - new root is allocated
> > - we need to switch to a special root
> >
> 
> KVM's MMU is an amazing maze so I'd appreciate if someone more
> knowledgeble corrects me;t my understanding is that we call
> *_flush_tlb_current() from two places:
> 
> kvm_mmu_load() and this covers the two cases above. These should not be
> common under normal circumstances but can be frequent in some special
> cases, e.g. when running a nested setup. Given that we're already
> running on top of Hyper-V, this means 3+ level nesting which I don't
> believe anyone really cares about.

Heh, don't be too sure about that.  People just love running "containers" inside
VMs, without thinking too hard about what they're doing :-)

In general, I don't like effectively turning KVM_REQ_TLB_FLUSH_CURRENT into
kvm_flush_remote_tlbs(), and I *really* don't like doing so for one specific
setup.  It's hard enough to capture the differences between KVM's various TLB
flushes hooks/requests, and special casing KVM-on-Hyper-V is just asking for
unique bugs.

Conceptually, I _think_ this is pretty straightforward: when a root is allocated,
flush the root on all *pCPUs*.  KVM currently flushes the root when a vCPU first
uses a root, which necessitates flushing on migration.

Alternatively, KVM could track which pCPUs a vCPU has run on, but that would get
expensive, and blasting a flush on alloc should be much simpler.

The two wrinkles I can think of are the x2APIC vs. xAPIC problem above (which I
think needs to be handled no matter what), and CPU hotplug (which is easy enough
to handle, I just didn't type it up).

It'll take more work than the below, e.g. to have VMX's construct_eptp() pull the
level and A/D bits from kvm_mmu_page (vendor code can get at the kvm_mmu_page with
root_to_sp()), but for the core concept/skeleton, I think this is it?

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6e838cb6c9e1..298130445182 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3839,6 +3839,37 @@ void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu)
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_free_guest_mode_roots);
 
+struct kvm_tlb_flush_root {
+       struct kvm *kvm;
+       hpa_t root;
+};
+
+static void kvm_flush_tlb_root(void *__data)
+{
+       struct kvm_tlb_flush_root *data = __data;
+
+       kvm_x86_call(flush_tlb_root)(data->kvm, data->root);
+}
+
+void kvm_mmu_flush_all_tlbs_root(struct kvm *kvm, struct kvm_mmu_page *root)
+{
+       struct kvm_tlb_flush_root data = {
+               .kvm = kvm,
+               .root = __pa(root->spt),
+       };
+
+       /*
+        * Flush any TLB entries for the new root, the provenance of the root
+        * is unknown.  Even if KVM ensures there are no stale TLB entries
+        * for a freed root, in theory another hypervisor could have left
+        * stale entries.  Flushing on alloc also allows KVM to skip the TLB
+        * flush when freeing a root (see kvm_tdp_mmu_put_root()), and flushing
+        * TLBs on all CPUs allows KVM to elide TLB flushes when a vCPU is
+        * migrated to a different pCPU.
+        */
+       on_each_cpu(kvm_flush_tlb_root, &data, 1);
+}
+
 static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
                            u8 level)
 {
@@ -3852,7 +3883,8 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
        WARN_ON_ONCE(role.direct && role.has_4_byte_gpte);
 
        sp = kvm_mmu_get_shadow_page(vcpu, gfn, role);
-       ++sp->root_count;
+       if (!sp->root_count++)
+               kvm_mmu_flush_all_tlbs_root(vcpu->kvm, sp);
 
        return __pa(sp->spt);
 }
@@ -5961,15 +5993,6 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
        kvm_mmu_sync_roots(vcpu);
 
        kvm_mmu_load_pgd(vcpu);
-
-       /*
-        * Flush any TLB entries for the new root, the provenance of the root
-        * is unknown.  Even if KVM ensures there are no stale TLB entries
-        * for a freed root, in theory another hypervisor could have left
-        * stale entries.  Flushing on alloc also allows KVM to skip the TLB
-        * flush when freeing a root (see kvm_tdp_mmu_put_root()).
-        */
-       kvm_x86_call(flush_tlb_current)(vcpu);
 out:
        return r;
 }
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 65f3c89d7c5d..3cbf0d612f5e 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -167,6 +167,8 @@ static inline bool is_mirror_sp(const struct kvm_mmu_page *sp)
        return sp->role.is_mirror;
 }
 
+void kvm_mmu_flush_all_tlbs_root(struct kvm *kvm, struct kvm_mmu_page *root);
+
 static inline void kvm_mmu_alloc_external_spt(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 {
        /*
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7f3d7229b2c1..3ff36d09b4fa 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -302,6 +302,7 @@ void kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu, bool mirror)
         */
        refcount_set(&root->tdp_mmu_root_count, 2);
        list_add_rcu(&root->link, &kvm->arch.tdp_mmu_roots);
+       kvm_mmu_flush_all_tlbs_root(vcpu->kvm, root);
 
 out_spin_unlock:
        spin_unlock(&kvm->arch.tdp_mmu_pages_lock);

