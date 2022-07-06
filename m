Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0552569547
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jul 2022 00:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiGFW1O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jul 2022 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiGFW1O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jul 2022 18:27:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406A2B194
        for <linux-hyperv@vger.kernel.org>; Wed,  6 Jul 2022 15:27:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s27so15145986pga.13
        for <linux-hyperv@vger.kernel.org>; Wed, 06 Jul 2022 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8En5VcDzJpRZUJVBlGHl7Q0Kg1P7kPCrXjhE+LYfN5M=;
        b=kUIIVGCvERQEwyak3xqYOSlBxS1t7NuI8dhRO8VQaU9LIJ4OHWPVFlkNrzzG8/4+4h
         9bMaqgsk8h471N0EWcKC28ueATACcd427UQJ08RGW/XfwbnTa9KOCj6Gj5+JKtgkIYNg
         mV42Sjkr8T7U+CFhVFGY2RkyxyF1dHwogJs/8kX8bMg77uOzJehO6zidjkXV+rS4rx28
         aX5yARkMcygsr/w43e7dqgSElHUG8h+okUWK+0TP0E7BCzKWbPcwMXc08LxXEtzyKbNl
         9oG04V8LDumUHN+BuX8c1em1gW0L+Y2EwVQw3ihOm5eJlblVDdaqBA/R8rsisN0ySVGr
         ownA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8En5VcDzJpRZUJVBlGHl7Q0Kg1P7kPCrXjhE+LYfN5M=;
        b=KpxYHlG/bfgf7dOcMdYGsVtT1q6LAedwGUHqd7HlBuKJ+vw5q75qQmilSPe46E7eIr
         9PRLl7ADaAYV4GrXnIpg3d44pdzKVPCoymwQUIN6SDX6r3PdZ0mANVDiH1yBrZawu/UO
         ij71zMzwQmnH7PTEXSIkVFlIy5VdNz+7If2Hf0cJWOlhskrhxASP4tSD1sppbZLEkvhg
         TvkfOItOkGJk4HQEd/UP+F6JkVT8cMa1Nw413PKY67Iyyn6ZbQvRU9potzUW1kkKfLkk
         6G0l2At4+VokDajfSWu7kI7CLwtX+36e5KiXxDLXiDwYaib+OOaqOsxW2Ardphq2AuPf
         X5tA==
X-Gm-Message-State: AJIora9yZ5yTnsw6CmUkcUdadsw5PjQnJz+L4rrRJUVPvlUdBUN1eRUo
        d/O2sy4Xwn5vCUBDAwLFEQ3Oew==
X-Google-Smtp-Source: AGRyM1vHvu+U2FyKN0UOsLIZn0q60hIVl9H32PwcOuMvAe5bhsFNxwgb8QQ+Rs8X2STgT9XFwF4Qyw==
X-Received: by 2002:a17:902:f708:b0:153:839f:bf2c with SMTP id h8-20020a170902f70800b00153839fbf2cmr49549892plo.113.1657146432846;
        Wed, 06 Jul 2022 15:27:12 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id e17-20020aa798d1000000b00525496442ccsm25310656pfm.216.2022.07.06.15.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:27:12 -0700 (PDT)
Date:   Wed, 6 Jul 2022 22:27:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/28] KVM: VMX: Get rid of eVMCS specific VMX
 controls sanitization
Message-ID: <YsYMPCr3/ig0xPFj@google.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-14-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629150625.238286-14-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 29, 2022, Vitaly Kuznetsov wrote:
> With the updated eVMCSv1 definition, there's no known 'problematic'
> controls which are exposed in VMX control MSRs but are not present in
> eVMCSv1. Get rid of the filtering.

Ah, this patch is confusing until one realizes that this is dropping the "filtering"
for what controls/features _KVM_ uses, whereas nested_evmcs_filter_control_msr()
filters controls that are presented to L1.

Can you add something to clarify that in the changelog?
