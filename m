Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B93B1E8178
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2020 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgE2PPX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 May 2020 11:15:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45492 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726940AbgE2PPX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 May 2020 11:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590765321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeLeCv9vM3H3I2JGP8/MuPPL1KTuklsFQ2TP2p7JQJw=;
        b=M9FTDzYyiSGCscIyg3j9iomddOYugXT391Tq3iJpjLdPY8Q9yPwtIasz0fdBRNPbDyiAlq
        7qO87TOdE8SPd5sRrzI0ri7EF4OSoS+DrgzxqrtSrWK26LGEpfwEfkYh9XOuSPK0NR8Wek
        nJr8Uf74Px4XBx6fCiOOxE9OnkZgKvg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-H6GkFyWTOoSdDswvgypvXg-1; Fri, 29 May 2020 11:15:20 -0400
X-MC-Unique: H6GkFyWTOoSdDswvgypvXg-1
Received: by mail-wr1-f70.google.com with SMTP id n6so1172933wrv.6
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2020 08:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SeLeCv9vM3H3I2JGP8/MuPPL1KTuklsFQ2TP2p7JQJw=;
        b=Z5gZxOGISt1bLMpdYt+r9My8kwLYxfQmM4N22AepT8Z1f8dXzfhftuQNIt8/eGw1yX
         2IJ6O+PpVnJcR+qmJbYaKv2xH5m3gRO6DVpOujH77cXXL3Ivd6OsM03/EE8u6VOEu4AD
         WCicgEo9g9RT340cLdefggjlneafXfaIhmH5t9ccUHbBocJYxuVNswOHOCFXEnjLGzB1
         5yCsxId1h/4Ol3BwNUDsUPziBv6dZXlllp01bojVGzZB/xCz9GsW6TbepptslZ/ADZ2x
         6UmIHMh0kXa3xvoClL9lx6u1mYRVWGqmubfB7ivlh2sPvAhyLocn5IcRzwKsIIH45Qjt
         0Z6g==
X-Gm-Message-State: AOAM532g8SQM0T47v7wNs7pbBlRvor5WN2fMdMiyg5C2cTGmBfpkeg7/
        A/gLr8Hlss7NDmNUBpMO6NKEvdXtp0IuBx2Ju3MPTVfyfAzZLPLikJn7iDvvwzX+ZLQAcroGkcH
        yWROABMuElzv58XiO6hfvdW4y
X-Received: by 2002:adf:ea90:: with SMTP id s16mr9045586wrm.299.1590765318899;
        Fri, 29 May 2020 08:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFgImluB9qe30SAnUY3gzbPTIKDHRP1THMFSMSV9kPen4yCHH/tgLWt4HMERiYDaS6qGoKuA==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr9045561wrm.299.1590765318672;
        Fri, 29 May 2020 08:15:18 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.89])
        by smtp.gmail.com with ESMTPSA id w3sm1919464wmg.44.2020.05.29.08.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 08:15:18 -0700 (PDT)
Subject: Re: [PATCH v12 0/6] x86/kvm/hyper-v: add support for synthetic
To:     Jon Doron <arilou@gmail.com>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, rvkagan@yandex-team.ru
References: <20200529134543.1127440-1-arilou@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4c0a79c-6048-43d2-a111-f206032ffbb6@redhat.com>
Date:   Fri, 29 May 2020 17:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200529134543.1127440-1-arilou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 29/05/20 15:45, Jon Doron wrote:
> Add support for the synthetic debugger interface of hyper-v, the synthetic
> debugger has 2 modes.
> 1. Use a set of MSRs to send/recv information (undocumented so it's not
>    going to the hyperv-tlfs.h)
> 2. Use hypercalls
> 
> The first mode is based the following MSRs:
> 1. Control/Status MSRs which either asks for a send/recv .
> 2. Send/Recv MSRs each holds GPA where the send/recv buffers are.
> 3. Pending MSR, holds a GPA to a PAGE that simply has a boolean that
>    indicates if there is data pending to issue a recv VMEXIT.
> 
> The first mode implementation is to simply exit to user-space when
> either the control MSR or the pending MSR are being set.
> Then it's up-to userspace to implement the rest of the logic of sending/recving.
> 
> In the second mode instead of using MSRs KNet will simply issue
> Hypercalls with the information to send/recv, in this mode the data
> being transferred is UDP encapsulated, unlike in the previous mode in
> which you get just the data to send.
> 
> The new hypercalls will exit to userspace which will be incharge of
> re-encapsulating if needed the UDP packets to be sent.
> 
> There is an issue though in which KDNet does not respect the hypercall
> page and simply issues vmcall/vmmcall instructions depending on the cpu
> type expecting them to be handled as it a real hypercall was issued.
> 
> It's important to note that part of this feature has been subject to be
> removed in future versions of Windows, which is why some of the
> defintions will not be present the the TLFS but in the kvm hyperv header
> instead.
> 
> v12:
> - Rebased on latest origin/master
> - Make the KVM_CAP_HYPERV_SYNDBG always enabled, in previous version
>   userspace was required to explicitly enable the syndbg capability just
>   like with the EVMCS feature.

I removed the capability altogether; the CPUID interface was added
exactly to avoid a proliferation of capabilities.

Otherwise it's great; queued, thanks.

Paolo

