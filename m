Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A331546B
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Feb 2021 17:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhBIQxF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Feb 2021 11:53:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232898AbhBIQwT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Feb 2021 11:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612889452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMFCghUYaXVO0TPsdfLQB4xSB9ytcAzqAbb8ycNDis8=;
        b=b3ERTsM1aEZxBdYG1gHXdLUriafIQ/RaUr2IUjFGw72lgZ/1Me6Vq6znHXyCemcKe4mtdV
        cME0Cj21EQT1klOFBnEImHhUMyNcGUjewOVQIePLZXFQlTBXLc7G2rnT++mNrORw/R1GVv
        v8HL0txa0CiGcOlwb+6apTXWlCq16Go=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-DAbiAOkfO-Ghg9XAX16a9w-1; Tue, 09 Feb 2021 11:50:48 -0500
X-MC-Unique: DAbiAOkfO-Ghg9XAX16a9w-1
Received: by mail-ed1-f72.google.com with SMTP id u24so15587534eds.13
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Feb 2021 08:50:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hMFCghUYaXVO0TPsdfLQB4xSB9ytcAzqAbb8ycNDis8=;
        b=KDHBOLh9Gcy29Drmne5HoanSJyngUQar0+Xi37PjjAV3gYhMDxcGiWt2GrfQ6dusDU
         BRVnlKOTDC+T/YIZQFMQKIi+4lgkMBRn2Gt+toYfjObhF2xbJU7Vx6YYKEZz4NRrCUKp
         FQPLb2bBK0EMxlCSTd7bY7bk9hrmrR6HhgDdM2ah+5nUZYFK9byXB3a/kiRC8BJ2Z2vG
         ZB+x74jTDXYtZE6HOOoahWdKcpnQ9kht1LDvjwggn3fafxA7UpE/6if/OfgO9mxuyutB
         glydiOJzinVpbdaHVbH0+rTHBGucNd6ro7qhbyjp5FrdvisPdlBOJjzef+ilWoVeL04H
         jbcg==
X-Gm-Message-State: AOAM531k16UrfVnd0pKHUfcADjN7fPRLgf6nlFe7zoDIBFYPGOxv0Xg9
        4WttXdcR8saty6RGEs82RQp0IRum3gi0yYeg+/3Rm/mHp92LawZJnU7WkJprlMNmZyqY8qcdz55
        ChPj/pWN81Dh7BBO+9VAVTs6SyJEulRarAYXOYHK1+h9VcafrVC4mc2HH27yQWP8ldvHh0pg9rw
        KU
X-Received: by 2002:a05:6402:1109:: with SMTP id u9mr9727275edv.385.1612889447877;
        Tue, 09 Feb 2021 08:50:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEElEHZ/GZqTxqZY2np6L/Y9ikvI2ORYYS0wUMuF8gnMbVMDmDtO9KfCTuJBqxpZnUsFny/A==
X-Received: by 2002:a05:6402:1109:: with SMTP id u9mr9727254edv.385.1612889447729;
        Tue, 09 Feb 2021 08:50:47 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i4sm10733055eje.90.2021.02.09.08.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:50:47 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** Checking Hyper-V
 hypercall status
In-Reply-To: <MWHPR21MB159399C0A82E28CE9A9B93DBD78E9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <MWHPR21MB159399C0A82E28CE9A9B93DBD78E9@MWHPR21MB1593.namprd21.prod.outlook.com>
Date:   Tue, 09 Feb 2021 17:50:46 +0100
Message-ID: <87lfbxmbh5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

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

Personally, I like it and think it's going to be sufficient.

Alternatively, I can suggest we introduce something like 

struct hv_result {
	u64 status:16;
	u64 rsvd1:16;
	u64 reps_comp:12;
	u64 rsvd1:20;
};

and make hv_do_rep_hypercall() return it. So the code above will look
like:

	struct hv_result result;

	result = hv_do_rep_hypercall(<some args>);
        if (result.status) == HV_STATUS_INSUFFICIENT_MEMORY) {
                <deposit more memory pages>
                goto retry;
        } else if (result.status != HV_STATUS_SUCCESS) {
                <handle error case>
        }
        completed = result.reps_comp;

-- 
Vitaly

