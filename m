Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE9316B9D
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Feb 2021 17:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhBJQrW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Feb 2021 11:47:22 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42367 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbhBJQqi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Feb 2021 11:46:38 -0500
Received: by mail-wr1-f45.google.com with SMTP id r21so3310636wrr.9
        for <linux-hyperv@vger.kernel.org>; Wed, 10 Feb 2021 08:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lWdOwD/yS6Cd8t3l3NWr8lJKWRMVHtZZMdP8dEy0JeQ=;
        b=c4tCMPVYvzcXq5u0LqyGzAbnz+0y+qUzMs98GeMngnZ65YkMR7UG/cW6SFYhJMP9xb
         6wstVhLxwzK8RvOTxG/gmWJNwZxGnBWPbNSeYHDD7xMQfDY6bOwPZfwqwMCIDGk8sPPi
         37PKu0x6Dy+oB2dZHVI14BtlmPLFD6zWkJnmIXwuo9XvBNQw8KA4/qpRlKKpkwg1AVOU
         YaJPBy01TxomWl+ooHP8VhGOIh5GA7HdBfWuwF1Ke10Iwm1VO2o84H3PqxzMhDekMWfO
         0mfH5JiHGKnN3a4EALV5Ttx26NMxHFM3GE7J00brt9FjDiZi5e0A6N0w0UpQFvk8Yn2n
         vMuA==
X-Gm-Message-State: AOAM53086uxMT/eq6fVP7NRmdaKlQ0cy3BFAh015HYzKiIfv2J3EGMQW
        wEcaThOlsYCSC/5nLfjZioJSigdfSLU=
X-Google-Smtp-Source: ABdhPJzavzp29Edze476Vn8jWXN3jdpSn2mVls1pCwHx1gDzCvNHFrO9zJokvwI/K/5kIHr5VAfGog==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr4488544wrp.175.1612975556639;
        Wed, 10 Feb 2021 08:45:56 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o18sm2895605wmp.19.2021.02.10.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:45:56 -0800 (PST)
Date:   Wed, 10 Feb 2021 16:45:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: Checking Hyper-V hypercall status
Message-ID: <20210210164554.zum5jmivdwwrovjj@liuwe-devbox-debian-v2>
References: <MWHPR21MB159399C0A82E28CE9A9B93DBD78E9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159399C0A82E28CE9A9B93DBD78E9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 09, 2021 at 03:45:23PM +0000, Michael Kelley wrote:
> As noted in a previous email, we don't have a consistent
> pattern for checking Hyper-V hypercall status.  Existing code and
> recent new code uses a number of variants.  The variants work, but
> a consistent pattern would improve the readability of the code, and
> be more conformant to what the Hyper-V TLFS says about hypercall
> status.  In particular, the 64 bit hypercall status contains fields that
> the TLFS says should be ignored -- evidently they are not guaranteed
> to be zero (though I've never seen otherwise).
> 
> I'd propose the following helper functions to go in
> asm-generic/mshyperv.h.  The function names are relatively short
> for readability:
> 
> static inline u64 hv_result(u64 status)
> {
> 	return status & HV_HYPERCALL_RESULT_MASK;
> }
> 
> static inline bool hv_result_success(u64 status)
> {
> 	return hv_result(status) == HV_STATUS_SUCCESS;
> }
> 
> static inline unsigned int hv_repcomp(u64 status)
> {
> 	return (status & HV_HYPERCALL_REP_COMP_MASK) >>
> 			HV_HYPERCALL_REP_COMP_OFFSET;
> }
> 
> The hv_do_hypercall() function (and its 'rep' and 'fast' variants) should
> always assign the result to a u64 local variable, which is the return
> type of the functions.  Then the above functions can act on that local
> variable.  Here are some examples:
> 
> 	u64		status;
> 	unsigned int	completed;
> 
> 	status = hv_do_hypercall(<some args>);
> 	if (!hv_result_success(status)) {
> 		<handle error case>
> 	}
> 
> 	status = hv_do_rep_hypercall(<some args>);
> 	if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
> 		<deposit more memory pages>
> 		goto retry;
> 	} else if (!hv_result_success(status)) {
> 		<handle error case>
> 	}
> 	completed = hv_repcomp(status);
> 
> 
> Thoughts?

I think this is definitely an improvement over open-coding everywhere.

Wei.
