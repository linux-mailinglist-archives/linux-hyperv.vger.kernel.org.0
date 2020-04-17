Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AAB1ADAAA
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2020 12:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDQKD0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Apr 2020 06:03:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52701 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbgDQKDZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Apr 2020 06:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587117804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ElYTrTrSJKdE2tYQriD77Ds10y+cL36iV21AUMPYK8=;
        b=WJ6FedXCjSxzHXR2Ym+0z1zXq7vuDaHcx3/n7he8xfb+zNnFspb5y2Ezq/R54s252jDtIB
        4QMIlVOgXjSuh/U1rXOy0ukLCZOZ8iRp8GhEGFBd64jabGU9O4Iad01EGn9obxD2N5Bqbx
        zmJu60jCA71qdNa8m+k0pmhX3lmMZVI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-m-Kl9QT3MAmqqUqmoIgO3w-1; Fri, 17 Apr 2020 06:03:22 -0400
X-MC-Unique: m-Kl9QT3MAmqqUqmoIgO3w-1
Received: by mail-wr1-f69.google.com with SMTP id m15so758754wrb.0
        for <linux-hyperv@vger.kernel.org>; Fri, 17 Apr 2020 03:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5ElYTrTrSJKdE2tYQriD77Ds10y+cL36iV21AUMPYK8=;
        b=ETTA+Am6iCRMGmV5Jniz+J9Y7JApNi2iyoUeSYvs0MFWtwCNG22gxItXUJVueccT4p
         pH0wlJYRzUJ0XHgULGELWm3BxUISoUKHxsvVAmYq+8QuBXp6QLFRFXjT/7/RwYjY1QAu
         GfQVgyXGYpMiadBYh7n6JZDKubhg3jsTrYHCaQCl26N5I1ISz2hpuxac60Cor0NOsw2h
         SZVWZ4UsrFrgTrOZCDaxG6moWesiw9v2kl+gAXem+iyE9xwqTOHH39DzrDhLV6Yd+wyL
         +4ner/LajGMI2LL6h5h5cWXhy2dGvnQXw0cPi13oscmtPK5GssZym5mjk2yimIpyyaEh
         Zj8w==
X-Gm-Message-State: AGi0PuZoCCSYdz9getxpNVYP9lCqcXisraDDD/pLC9lxi3t0NDjuU5Sg
        HxWxYj8fmRC7wn/EuGiCFCV8J1N3aMafqvzv/o3NpXz7H8CWxpUfJI03m0EeLekLI5S3LhfVw7F
        XdqaCBR1dFNK69u2vdvjHOoXm
X-Received: by 2002:adf:97cc:: with SMTP id t12mr2964677wrb.261.1587117801267;
        Fri, 17 Apr 2020 03:03:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYH+JBn8/yn3IYbL7Qlc8+A7kS9lt5b8RYcDiZb5T6r+5ekluPE9YgLZGiyQIkvKPQZtVJZg==
X-Received: by 2002:adf:97cc:: with SMTP id t12mr2964656wrb.261.1587117801045;
        Fri, 17 Apr 2020 03:03:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s8sm1178080wru.38.2020.04.17.03.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 03:03:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     bp@alien8.de, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org,
        mikelley@microsoft.com, wei.liu@kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Suspend/resume the VP assist page for hibernation
In-Reply-To: <1587104999-28927-1-git-send-email-decui@microsoft.com>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com>
Date:   Fri, 17 Apr 2020 12:03:18 +0200
Message-ID: <87blnqv389.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> Unlike the other CPUs, CPU0 is never offlined during hibernation. So in the
> resume path, the "new" kernel's VP assist page is not suspended (i.e.
> disabled), and later when we jump to the "old" kernel, the page is not
> properly re-enabled for CPU0 with the allocated page from the old kernel.
>
> So far, the VP assist page is only used by hv_apic_eoi_write().

No, not only for that ('git grep hv_get_vp_assist_page')

KVM on Hyper-V also needs VP assist page to use Enlightened VMCS. In
particular, Enlightened VMPTR is written there.

This makes me wonder: how does hibernation work with KVM in case we use
Enlightened VMCS and we have VMs running? We need to make sure VP Assist
page content is preserved.

-- 
Vitaly

