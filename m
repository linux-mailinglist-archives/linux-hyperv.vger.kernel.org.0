Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A857170FBD3
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 May 2023 18:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjEXQle (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 May 2023 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjEXQld (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 May 2023 12:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCD9123
        for <linux-hyperv@vger.kernel.org>; Wed, 24 May 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684946445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zbhz5u+O2nNXdtmS5V2mgp+v9A1AIo3AJJNjTTAhOcc=;
        b=NyRTJdivPyEZTrOUEo0u/LYJ6RXRJdXMWhS41aFCfH6n0Bzig3IVcfHsTXSob9xgBOKw6T
        Y+Qh91+1AgDzrnH+xiwOOf3eqCYMwba64l3lA5380SonZwS6KLaCYL2dGg2sR4bSllJNQE
        7jBZnGyVRaoFM67cS7OKYICsI6jNLys=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-wYNYUWfROSuBRe5X6g9miA-1; Wed, 24 May 2023 12:40:43 -0400
X-MC-Unique: wYNYUWfROSuBRe5X6g9miA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so5052155e9.3
        for <linux-hyperv@vger.kernel.org>; Wed, 24 May 2023 09:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946442; x=1687538442;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbhz5u+O2nNXdtmS5V2mgp+v9A1AIo3AJJNjTTAhOcc=;
        b=LTO5RExvAVHuTPGY8OxotC46oX4Jm43nhk8dJ5ryAa7M3VFbnVIp8NefH/9LfLghZ2
         anXLWakWbmjZjQeS935p9z56haub3ZDa/gtCOJ9fVw2nDfV5nSiVUiJm/I4GxJGxyHv8
         wsI0qu2nKmQO0F3fS9/U41xPTHRz3NjrWqHoK71Bk4lmtnKIVVCXHrmTa7NVyB0EQPH/
         SFzJ3DDPUgLm+cknPsNv2E21hEtGyIMM8QxeB3KEwzwoR5TaAB42fLtkY5n4WuO6Fy6I
         oF31ovRqzd8p5grZf6H/S25Fzz1HF9z+nG3Eq1z+3PhVBUgVo218wm3oJiXlgbsujvFb
         UGtg==
X-Gm-Message-State: AC+VfDyynRodtRtfYPdfx46npXLeMb+C9plJBas6JZ1krTF+F2Nptm4p
        wL6HwCyJd9fH0JafAGULHRfteC4HoIid5uKGdc+EICjEGLdmrH/YECPyIJfwc/6epcXdhgf+1fg
        uEIRjtd5VULUoti7aT8K4iylM
X-Received: by 2002:a05:600c:2111:b0:3f6:fb2:add4 with SMTP id u17-20020a05600c211100b003f60fb2add4mr244906wml.33.1684946442754;
        Wed, 24 May 2023 09:40:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pE3yaKxCYX7zqqrKH6+W+ikC4iDSemy7egKZCbhh7dr5ElNQFIVkvnmdZL9w3/iWAnmCCqQ==
X-Received: by 2002:a05:600c:2111:b0:3f6:fb2:add4 with SMTP id u17-20020a05600c211100b003f60fb2add4mr244870wml.33.1684946442433;
        Wed, 24 May 2023 09:40:42 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003f6038faa19sm2808325wmj.19.2023.05.24.09.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:40:41 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, bigeasy@linutronix.de
Cc:     mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        pbonzini@redhat.com, wanpengli@tencent.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        daniel.lezcano@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        rafael@kernel.org, peterz@infradead.org, longman@redhat.com,
        boqun.feng@gmail.com, pmladek@suse.com, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, jstultz@google.com, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 03/13] arm64/io: Always inline all of
 __raw_{read,write}[bwlq]()
In-Reply-To: <20230519102715.368919762@infradead.org>
References: <20230519102058.581557770@infradead.org>
 <20230519102715.368919762@infradead.org>
Date:   Wed, 24 May 2023 17:40:39 +0100
Message-ID: <xhsmhpm6pptrs.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 19/05/23 12:21, Peter Zijlstra wrote:
> The next patch will want to use __raw_readl() from a noinstr section
> and as such that needs to be marked __always_inline to avoid the
> compiler being a silly bugger.
>
> Turns out it already is, but its siblings are not. Finish the work
> started in commit e43f1331e2ef913b ("arm64: Ask the compiler to
> __always_inline functions used by KVM at HYP") for consistenies sake.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

