Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9402CCA77
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Dec 2020 00:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgLBXXT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 18:23:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33570 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLBXXS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 18:23:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id u12so6899wrt.0;
        Wed, 02 Dec 2020 15:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vhazsnwkBN4W5bW7O942iWaDDf+hT2e4BRRd7kmtCxk=;
        b=cn5d/9u0iBmN3qrU1cIgrFmALe0gWqS8hrs2Tx2XU5STLG5N0ZEdF46eHIk/ERImkh
         9CnKUIBN1Ojd042sT5AVO1NumdDCMwbV/s3xhTEt85L8tz3muMB6zCH1lz8RHSdDnf/f
         +F7lrJE4oF5CfNfGAyooP3PiTMNTM624nMQ6fCxX9Ze7oJXswICqSBRfOK+cbPo7AzdU
         1m/ib3Hdqw7RQNT36CKe16l8Zy84veThPkYyuKPyIoefR7sVcveB5l4y/p3TzGHIQPbg
         O03oXCibkGzlRUHfk6zkgTkYsgpfDpCJpOBb/qP1SX9/dFF5IxEIUnungAYEwjMypJ2a
         Rlkw==
X-Gm-Message-State: AOAM5334PZb0JYCi7MdnMYvH/+coMd7auVaTod9mfqXcTa7x0kYamR+5
        vadJbpZf2BYI3ocTV5GF/bY=
X-Google-Smtp-Source: ABdhPJwfx0KMkyXddeSfYgQzOOwxcl+ncL7oFhNmZQjEMNEOFs7rbcaWlo6BLSvWqXcN6wzzmZ4Abw==
X-Received: by 2002:adf:a495:: with SMTP id g21mr422743wrb.213.1606951356855;
        Wed, 02 Dec 2020 15:22:36 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 90sm207272wrl.60.2020.12.02.15.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:22:36 -0800 (PST)
Date:   Wed, 2 Dec 2020 23:22:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        sameo@linux.intel.com, robert.bradford@intel.com,
        sebastien.boeuf@intel.com
Subject: Re: [PATCH v3 00/17] Introducing Linux root partition support for
 Microsoft Hypervisor
Message-ID: <20201202232234.5buzu5wysiaro3hc@liuwe-devbox-debian-v2>
References: <20201124170744.112180-1-wei.liu@kernel.org>
 <227127cf-bfea-4a06-fcbc-f6c46102e9e6@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <227127cf-bfea-4a06-fcbc-f6c46102e9e6@metux.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 02, 2020 at 08:51:38PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 24.11.20 18:07, Wei Liu wrote:
> 
> Hi,
> 
> > There will be a subsequent patch series to provide a
> > device node (/dev/mshv) such that userspace programs can create and run virtual
> > machines. 
> 
> Any chance of using the already existing /dev/kvm interface ?
> 

I don't follow. Do you mean reusing /dev/kvm but with a different set of
APIs underneath? I don't think that will work.

In any case, the first version of /dev/mshv was posted a few days ago
[0].  While we've chosen to follow closely KVM's model, Microsoft
Hypervisor has its own APIs.

Wei.

0: https://lore.kernel.org/linux-hyperv/1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com/

> --mtx
> 
> -- 
> ---
> Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
> werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schlüssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
