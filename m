Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24593E36D9
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Oct 2019 17:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405861AbfJXPlV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Oct 2019 11:41:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55216 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbfJXPlV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Oct 2019 11:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571931679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3wFDaqZ0NbxQNGne9paddG3mzo8aRis+uvC8kKNNdSM=;
        b=TOZ7iUymbzXb0W1Shtt8HREuL0eQDT5Kvo5R+3KJG6mxQo8HF+hrdiEiUA19RsqjDNiFw0
        2NDoslv2dqxyAc2F1JSwOdtq2FWwskmZtqCc4sLJdg3UR2aBFiMxT/IiqJi8R22C2RQfbx
        KAmFnGhxgcyGTYW+/92YZ8807sgyxro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-ra28wWr0N-iUCwABpxgLJw-1; Thu, 24 Oct 2019 11:41:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35FCA801E74;
        Thu, 24 Oct 2019 15:21:58 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.34.246.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90C7C5D9CA;
        Thu, 24 Oct 2019 15:21:53 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
Date:   Thu, 24 Oct 2019 17:21:52 +0200
Message-Id: <20191024152152.25577-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ra28wWr0N-iUCwABpxgLJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When sending an IPI to a single CPU there is no need to deal with cpumasks.
With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
cycles) improvement with smp_call_function_single() loop benchmark. The
optimization, however, is tiny and straitforward. Also, send_ipi_one() is
important for PV spinlock kick.

I was also wondering if it would make sense to switch to using regular
APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CPU
cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
vector)).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_apic.c           | 22 +++++++++++++++++++---
 arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index e01078e93dd3..847f9d0328fe 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -194,10 +194,26 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int vector)
=20
 static bool __send_ipi_one(int cpu, int vector)
 {
-=09struct cpumask mask =3D CPU_MASK_NONE;
+=09int ret;
=20
-=09cpumask_set_cpu(cpu, &mask);
-=09return __send_ipi_mask(&mask, vector);
+=09trace_hyperv_send_ipi_one(cpu, vector);
+
+=09if (unlikely(!hv_hypercall_pg))
+=09=09return false;
+
+=09if (unlikely((vector < HV_IPI_LOW_VECTOR) ||
+=09=09     (vector > HV_IPI_HIGH_VECTOR)))
+=09=09return false;
+
+=09if (cpu >=3D 64)
+=09=09goto do_ex_hypercall;
+
+=09ret =3D hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
+=09=09=09=09     BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
+=09return ((ret =3D=3D 0) ? true : false);
+
+do_ex_hypercall:
+=09return __send_ipi_mask_ex(cpumask_of(cpu), vector);
 }
=20
 static void hv_send_ipi(int cpu, int vector)
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/tra=
ce/hyperv.h
index ace464f09681..4d705cb4d63b 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -71,6 +71,21 @@ TRACE_EVENT(hyperv_send_ipi_mask,
 =09=09      __entry->ncpus, __entry->vector)
 =09);
=20
+TRACE_EVENT(hyperv_send_ipi_one,
+=09    TP_PROTO(int cpu,
+=09=09     int vector),
+=09    TP_ARGS(cpu, vector),
+=09    TP_STRUCT__entry(
+=09=09    __field(int, cpu)
+=09=09    __field(int, vector)
+=09=09    ),
+=09    TP_fast_assign(__entry->cpu =3D cpu;
+=09=09=09   __entry->vector =3D vector;
+=09=09    ),
+=09    TP_printk("cpu %d vector %x",
+=09=09      __entry->cpu, __entry->vector)
+=09);
+
 #endif /* CONFIG_HYPERV */
=20
 #undef TRACE_INCLUDE_PATH
--=20
2.20.1

