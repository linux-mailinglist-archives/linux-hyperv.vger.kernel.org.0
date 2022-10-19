Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA36052C5
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Oct 2022 00:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJSWJC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Oct 2022 18:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJSWJB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Oct 2022 18:09:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D921C39C2
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Oct 2022 15:09:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so1245391pjf.5
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Oct 2022 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElnUUXLD7t/51ihXU8IsUAN/zVEivTS6JYTitIEyOjk=;
        b=Zwbbn1ALBaH8g0LFCDFEU+0Xb3r7aRtuvTSgJDCP1F5krs+qZRdOl1/DbmW9RjhbsE
         C0X2Rsta0l3koyI/99a/yLhdRh5Oe5/T4wkk3UcZwTo95hB1grzCMp2vzxCwzZI8PrK/
         Hm5tYF51pkZGpD7QeJwvAeWJDY2b2D0fAfWweSKrORIb5qNcaVwivTadhVUJG8F5Dyfu
         cK5J75CBlf1g7xpNo5ivcdga6M+atmEda2YBx6IGQcdXMX9xncBVfuokrym1UOxdppUg
         aB4o82i/Sx4k2uCL7m6IPvzuCCloJflRraOEFKQntlqtD+SblJ0l8Ggs4IuEv0P+mR9K
         P3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElnUUXLD7t/51ihXU8IsUAN/zVEivTS6JYTitIEyOjk=;
        b=vdoWrr2+pyMZJQ3H367frcOPwjM7Mew6zns8bPyBPHSnt1RBKKAwVon14tyAEkDs55
         Pw5RbBwo94h/ZbmWkNVnA5S3G/5OJCHA38bRzaObXmw80cS4yPeFQSJqqmIutpVJM9w4
         TgnHfiOJX9/BXotAZggdnNvLkyP/RTnOVvXmSWwLUxe2BcOu8B46vMA6NgTIRBLkYinp
         Baa7m+ylsPoS+lTJhqqL8drrps67g2Tb8atrg4cRLw7ALGncph76Q5Cd2EcWRv/e12t9
         Uto3xikbDRqqRfxvwO5TPk6ZLG/XgvRZwZjp/9QfGwidRwy/o7ZdQuprTrLjSWdV/y1k
         YbSg==
X-Gm-Message-State: ACrzQf1e7ZZimPJIlez0XGoGCj4IWLJYNEK+h6/XbE7CxktZ2bKZxohl
        mutgZuXu5BVcU7PK7OLejcchnQ==
X-Google-Smtp-Source: AMsMyM5IvBgcgrLUf0leSbCJbFKi5aXDuC2hatOqA2x7byARrqJhXe66mX0ymcPoWoH6zce92GxabQ==
X-Received: by 2002:a17:902:8549:b0:178:6399:3e0f with SMTP id d9-20020a170902854900b0017863993e0fmr10754786plo.35.1666217340071;
        Wed, 19 Oct 2022 15:09:00 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b00174c0dd29f0sm11316735plh.144.2022.10.19.15.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:08:59 -0700 (PDT)
Date:   Wed, 19 Oct 2022 22:08:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 33/46] KVM: selftests: Hyper-V PV IPI selftest
Message-ID: <Y1B1eBIL9WhB4dwc@google.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <20221004123956.188909-34-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004123956.188909-34-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:
> +static void *vcpu_thread(void *arg)
> +{
> +	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)arg;
> +	struct ucall uc;
> +	int old;
> +	int r;
> +	unsigned int exit_reason;
> +
> +	r = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &old);
> +	TEST_ASSERT(r == 0,
> +		    "pthread_setcanceltype failed on vcpu_id=%u with errno=%d",
> +		    vcpu->id, r);
> +
> +	vcpu_run(vcpu);
> +	exit_reason = vcpu->run->exit_reason;
> +
> +	TEST_ASSERT(exit_reason == KVM_EXIT_IO,
> +		    "vCPU %u exited with unexpected exit reason %u-%s, expected KVM_EXIT_IO",
> +		    vcpu->id, exit_reason, exit_reason_str(exit_reason));
> +
> +	if (get_ucall(vcpu, &uc) == UCALL_ABORT) {
> +		TEST_ASSERT(false,
> +			    "vCPU %u exited with error: %s.\n",
> +			    vcpu->id, (const char *)uc.args[0]);

REPORT_GUEST_ASSERT_N()?

> +	}
> +
> +	return NULL;
> +}
> +
> +static void cancel_join_vcpu_thread(pthread_t thread, struct kvm_vcpu *vcpu)
> +{
> +	void *retval;
> +	int r;
> +
> +	r = pthread_cancel(thread);
> +	TEST_ASSERT(r == 0,

!r is generally preferred over "r == 0"

> +		    "pthread_cancel on vcpu_id=%d failed with errno=%d",
> +		    vcpu->id, r);

Do you happen to know if errno is preserved?  I.e. if TEST_ASSERT()'s print of
errno will capture the right errno?  If so, this and the pthread_join() assert
can be:

	TEST_ASSERT(!r, pthread_cancel() failed on vcpu_id=%d, vcpu->id);

> +
> +	r = pthread_join(thread, &retval);
> +	TEST_ASSERT(r == 0,
> +		    "pthread_join on vcpu_id=%d failed with errno=%d",
> +		    vcpu->id, r);

...

> +	r = pthread_create(&threads[0], NULL, vcpu_thread, vcpu[1]);
> +	TEST_ASSERT(r == 0,
> +		    "pthread_create halter failed errno=%d", errno);
> +
> +	r = pthread_create(&threads[1], NULL, vcpu_thread, vcpu[2]);
> +	TEST_ASSERT(r == 0,
> +		    "pthread_create halter failed errno=%d", errno);

Similar comments as above.

> +
> +	while (true) {
> +		r = _vcpu_run(vcpu[0]);
> +		exit_reason = vcpu[0]->run->exit_reason;
> +
> +		TEST_ASSERT(!r, "vcpu_run failed: %d\n", r);

Why use _vcpu_run() with a manual assert?  Won't the vanilla vcpu_run() do what
you want?
