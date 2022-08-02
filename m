Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BC758803C
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Aug 2022 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiHBQ20 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Aug 2022 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiHBQ2U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Aug 2022 12:28:20 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0674D37183
        for <linux-hyperv@vger.kernel.org>; Tue,  2 Aug 2022 09:28:19 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f192so4586753pfa.9
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Aug 2022 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=m5JXOmTfBKNUXaoyaUbMC0qVBYGlHYto5nPX9Patf5M=;
        b=N3NHL+iPO2a8XKIjeTt0N8pPFLwVwZlbHqWt5VKUt27XsormudLJOb4NQoxPULnpGV
         S3Hfe5bmahuKbxOHGW5KmgZyIjQwUDkx2n913wEB3xVzIuCxS3z9twvBoYubojbCC7b9
         8dCkyh6jv3mhM4rYqRiQqahOfZaz/cgGCgetM9RwgLfjLbkNA+oOH/WAIY23L0HCjPak
         OxdK4wAsJHtwld6FCG4S2cb7+/hLvQg4ir+i/dVHOURKO1YpU0gnEKeQw1Ldbn49/WMo
         00otGN7UcAsKISwh5gABrijybH0x+OOo0hmeyLRYZGRUzYUbkLdkm2W8e5/LJexmfZNk
         aD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=m5JXOmTfBKNUXaoyaUbMC0qVBYGlHYto5nPX9Patf5M=;
        b=FoxZF3U+geEdxyTB7hBMwzW8hatEgeD5fS8IOLC6o3n8Kp+y8KGEP/sf4DthPSPu5m
         Hw58nAhiPCEeQLnmMyka1NFS2E4SC8E335wRVMyJuxn9LSZylbjLuAI86uSZ3ZOfp5lB
         aUH5fn37ApSCx0Uvh9emTEuXwsHfpqyPWSWfWHAnB1JAbBmgMz7gczfdCtE8mmh35hDd
         a5eSdpr6q+5miw5d9rxgZalzrUfiQ6xjgzZYVYE8hS4JK7Ck4CyjgRmkFFwWbOLLVsdm
         byatgwJDgg3xLI3zQ1nJgBg7UUDoc7qtWC80ewun9bH1Riim7GFm58nwB72g4KHu1FnQ
         dbWw==
X-Gm-Message-State: AJIora/aT7QIVAnYJiSpJ/EAMNFFDlsO92QXwkDUQ1Kk+GtzgtwriG0i
        yqIG9sXTDUdiSmvw8L/lcw/QBw==
X-Google-Smtp-Source: AA6agR4MVlTUXHxYv42qQK7I867lJYSH5V8kCMUvlZJOb5W6zuqliBqtjyG++1chXju46MQoWV9twg==
X-Received: by 2002:a05:6a00:cd5:b0:52b:1744:af86 with SMTP id b21-20020a056a000cd500b0052b1744af86mr21392255pfv.19.1659457698396;
        Tue, 02 Aug 2022 09:28:18 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z16-20020a170902ccd000b0016c4e4538c9sm12033114ple.7.2022.08.02.09.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 09:28:18 -0700 (PDT)
Date:   Tue, 2 Aug 2022 16:28:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 24/25] KVM: VMX: Cache MSR_IA32_VMX_MISC in vmcs_config
Message-ID: <YulQniIhC25F+pT7@google.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-25-vkuznets@redhat.com>
 <Ytnb2Zc0ANQM+twN@google.com>
 <87fsie1v8q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsie1v8q.fsf@redhat.com>
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

On Tue, Aug 02, 2022, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
> >> @@ -2613,6 +2614,8 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
> >>  	if (((vmx_msr_high >> 18) & 15) != 6)
> >>  		return -EIO;
> >>  
> >> +	rdmsrl(MSR_IA32_VMX_MISC, misc_msr);
> >
> > Might make sense to sanitize fields that KVM doesn't use and that are not exposed
> > to L1.  Not sure it's worthwhile though as many of the bits fall into a grey area,
> > e.g. all the SMM stuff isn't technically used by KVM, but that's largely because
> > much of it just isn't relevant to virtualization.
> >
> > I'm totally ok leaving it as-is, though maybe name it "unsanitized_misc" or so
> > to make that obvious?
> 
> I couldn't convince myself to add 'unsanitized_' prefix as I don't think
> it significantly reduces possible confusion (the quiestion would be
> 'sanitized for what and in which way?') so a need for 'git grep' seems
> imminent anyway.

Yeah, no objection to leaving it alone.  VMX_MISC is such an oddball MSR that it
practically comes with disclaimers anyways :-)
