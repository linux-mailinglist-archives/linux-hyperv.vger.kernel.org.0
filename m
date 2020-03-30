Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82D19789C
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2020 12:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgC3KNh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Mar 2020 06:13:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54631 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgC3KNg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Mar 2020 06:13:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id c81so19295330wmd.4;
        Mon, 30 Mar 2020 03:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=etNRfQXSTquo6SrTToC0ZDG3tsM3oRH7bak2nuOj9kc=;
        b=XoELc/LLXnZ8xFCflQqxeKvMu7ldJfcZYDKsztN1rvaAGMaM6IhRzHZ7wUWHHGNYN6
         nYoPqtwrtDl49yWz0zth/4YNKAJtiGoJxo6aortb/vqfIlBIci7l5AduGnAI7ue+kjJ7
         8FwptMBAXbPxIEIPIJC8HrRpJmxbvEYqfbHX+NbnWtWdP76vll6q8qdC4Yk6by9LcY2r
         o9YcwrGuajB7ic/wKAZI7PSVbPKzglwfaZKOnqKSM5Jc0aKPwGGew55SHhTsekNswUpN
         s2kZceJSE716YrDUHZFY9s/xBd0FSUUMDW4KyY5c163O8wu0OvSZbXjuMsJdBrXqzm8X
         M5Gg==
X-Gm-Message-State: ANhLgQ3HGf0ORLkUkKGwK3oOWEfL2zlE/zPliPsKLOB4U744M6/yuP3K
        HizZXNYq0aRLGeUsSHojmyk=
X-Google-Smtp-Source: ADFU+vt2FVxAIyS5YUdgBwUhS6YMoWQIE/YsEKA0AOhmRG0GEtKmB0X0UOqqN4OC7wZ/vUSbYtCHiQ==
X-Received: by 2002:a1c:9e16:: with SMTP id h22mr4682635wme.27.1585563214463;
        Mon, 30 Mar 2020 03:13:34 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id o67sm21140400wmo.5.2020.03.30.03.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 03:13:33 -0700 (PDT)
Date:   Mon, 30 Mar 2020 11:13:31 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     ltykernel@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH V3 0/6] x86/Hyper-V: Panic code path fixes
Message-ID: <20200330101331.v4yahaqszgbo27km@debian>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 24, 2020 at 12:57:14AM -0700, ltykernel@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> This patchset fixes some issues in the Hyper-V panic code path.
> Patch 1 resolves issue that panic system still responses network
> packets.
> Patch 2-3,5-6 resolves crash enlightenment issues.
> Patch 4 is to set crash_kexec_post_notifiers to true for Hyper-V
> VM in order to report crash data or kmsg to host before running
> kdump kernel.
> 
> Tianyu Lan (6):
>   x86/Hyper-V: Unload vmbus channel in hv panic callback
>   x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
>   x86/Hyper-V: Trigger crash enlightenment only once during  system
>     crash.
>   x86/Hyper-V: Report crash register data or ksmg before  running crash
>     kernel
>   x86/Hyper-V: Report crash register data when sysctl_record_panic_msg
>     is not set
>   x86/Hyper-V: Report crash data in die() when panic_on_oops is set
> 

Queued to hyperv-next. Thanks.

Wei.
