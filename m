Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446B1CFD2D
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfJHPI4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 11:08:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35235 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfJHPI4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 11:08:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so19855942wrt.2;
        Tue, 08 Oct 2019 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ypd77sdI6iiTLiz63NonJkbWe8JwhMk44SAfmiueuoc=;
        b=uxnp6etD5XoaSu0yi0hFGvxt451EBociY6enT1pSfprhEwuuqYFBrD19UZT1OiEacS
         T5HZfM/8P8OysxhDB3Tt8nQk+vOkellJpmc8dm46/M53rikQHHCCWeShbqMDR4Oy72e2
         QuWtlu5roeWuveMehy4a9RIjuStXydJDXXIsO8+0W634+Osbbz7/FHnKcs5vw+we10Q4
         A1Utq+3deP54xbx7svkMPIlVPdfQkRGOx8+JntEJsRnSH903ZUr5NIg+vJOCmpCSLL/x
         oTXcK1Tjdab6HamtyQsl4/nt9U7ZtZ3zvUoGUc0qaBh3/oQeo3UPwfVNSXL+fMUmeWCs
         Z4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ypd77sdI6iiTLiz63NonJkbWe8JwhMk44SAfmiueuoc=;
        b=dYEejs3qqdi6cn5ThZMQwK4xD3mG5rQO8fopGakY8Lja48VyLtTKmKi3wELOQy9lpU
         PxujYXug3t7ACv5jh78XZDKTRdB6YIY4lN2ot1p0xycwrqScGd3zCsda/hzxeF7mWx8J
         dCu5WNv3ANqWPMSGHFucQ3sQBCigtrzf8V7poosDDhcBK4opdZUAPVvjXGEQlfjI19lO
         Rx43nptq0Z3bCiVPcdXlRnQbFKADWglm0qkJHEgGZSLvRyHIiXM5MMI3gMVoCTZdBgM7
         2JPWgKX2rTVi8S3viNVARnYQPK/4A8Oh/DLDd+qSpjdqcSKr818XWLg+yRTEaAknEZVR
         LBzg==
X-Gm-Message-State: APjAAAVhyW3BlnsmpmhOFjc5XYbk9rRIzfwbd7ocQijDigVHJlXK27q8
        ACO2fo6gL82RBl8cYThNjy4ofnu3n/YcZw==
X-Google-Smtp-Source: APXvYqwf+M20DLNB55AVht/sasmDqPwm9ID+kX0fL26iK+cUhkhDcRYCGfKb96eN7bXep+C0sqoojQ==
X-Received: by 2002:adf:fb11:: with SMTP id c17mr29147606wrr.0.1570547334208;
        Tue, 08 Oct 2019 08:08:54 -0700 (PDT)
Received: from andrea (userh648.uk.uudial.com. [194.69.103.21])
        by smtp.gmail.com with ESMTPSA id r2sm5965686wma.1.2019.10.08.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:08:53 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:08:47 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH 0/2] Drivers: hv: vmbus: Miscellaneous improvements
Message-ID: <20191008150847.GA15276@andrea>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
 <PU1P153MB01691E9B0DD83E521B1E12C0BF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01691E9B0DD83E521B1E12C0BF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 07, 2019 at 05:41:10PM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Andrea Parri
> > Sent: Monday, October 7, 2019 9:31 AM
> > 
> > Hi all,
> > 
> > The patchset:
> > 
> > - simplifies/refactors the VMBus negotiation code by introducing
> >   the table of VMBus protocol versions (patch 1/2),
> > 
> > - enables VMBus protocol versions 5.1 and 5.2 (patch 2/2).
> > 
> > Thanks,
> >   Andrea
> > 
> > Andrea Parri (2):
> >   Drivers: hv: vmbus: Introduce table of VMBus protocol versions
> >   Drivers: hv: vmbus: Enable VMBus protocol versions 5.1 and 5.2
> 
> Should we add a module parameter to allow the user to specify a lower
> protocol version, when the VM runs on the latest host? 
> 
> This can be useful for testing and debugging purpose: the variable
> "vmbus_proto_version" is referenced by the vmbus driver itself and
> some VSC drivers: if we always use the latest available proto version,
> some code paths can not be tested on the latest hosts. 

The idea is appealing to me (altough I made no attempt to implement/test
it yet).  What do others think about this?  Maybe can be considered as a
follow-up patch/work to this series?

Thanks,
  Andrea
