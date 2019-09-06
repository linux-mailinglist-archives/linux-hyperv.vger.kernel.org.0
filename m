Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18825AAFB3
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 02:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389509AbfIFAOB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 20:14:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41505 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389391AbfIFAOB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 20:14:01 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so8798815ioh.8;
        Thu, 05 Sep 2019 17:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nJVwwPSAJKVbMbsLZ7VhY19jh2tOjHarFelaWr5DkmM=;
        b=OAFKh8Uk/OpeBEl5IM4Hb86xkRhQaV/2jTeQCc6WZg/Wenq2PXT4upoXc2NF4HJmr4
         X1P/l6Ja8YC7pFSGLUkuHJ8eyYo+MKotckGZ4fzUPDhNbf4+BUSRAn7nkSitwu3Tucmv
         FBhpm42qlSVUsZsMMGaWGl4D0W7TwNo06cVkPXwJn5F5se+f+n2Tepyq/DS6UhlLiNn5
         kBoQvcslAw6OMb/kSjF8Me74EaNIFaQUJjul9fyEdfXepP5JUnfmUnK4vE5rO2R0mBnB
         Sk1Gmnn1vyUiKwjjyuSzyh/WouYfylxcO45JjpJTBl6DhzYQ2KhhoZXyN587c53P6yTH
         4zsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nJVwwPSAJKVbMbsLZ7VhY19jh2tOjHarFelaWr5DkmM=;
        b=iXxsBfWvx9z24pIM8uvrIgVUjGBZsAuXI/dCp1Xt093l/Hjzh1wMolktfG0q2v7K4M
         jS1bBXr8jxWdnW3qEy7by4to6kwsvoCr2sq9KfFIVpbSst1CAQkrUQxuGyAvD/eMEV9Q
         x1ms2rRn60RKCU6pzsGXCzXChwzmhMIjy8LfkTRN51iPneL0fZR4Y/e3dhcHxyn+UlQJ
         cN4mJfXsg1Y2i3NxhOx6eRonEXvgrBdjk+McX5KVKhlEEGNSwFnU2ukRfyN4cNHP9V4n
         VEJEWRySmVxErAI24/TwtUkeYXBVapPSs4YADRnu4ht+/lrUTiZBq8j/pMPLAHebU8bA
         Envg==
X-Gm-Message-State: APjAAAVndyyqTdYKu+Y4+JZxnwuDEqWs82t/doEzFqKpkxTJde0ZfYYO
        gmFfjlEfBMxaTF/FtxaCrQ==
X-Google-Smtp-Source: APXvYqzT2Xor7edLiL1XzktT3DBrWzzdvfX5Iz2WUTIaqNdyXPwfyzimT2M5f4q0P0OqiUGHaS2DpQ==
X-Received: by 2002:a5e:8c01:: with SMTP id n1mr7253657ioj.152.1567728840096;
        Thu, 05 Sep 2019 17:14:00 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id s201sm7974407ios.83.2019.09.05.17.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 17:13:58 -0700 (PDT)
Date:   Thu, 5 Sep 2019 20:13:56 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] drivers: hv: vmbus: Introduce latency testing
Message-ID: <20190906001356.GA17342@Test-Virtual-Machine>
References: <cover.1567047549.git.brandonbonaby94@gmail.com>
 <da1ab5c98ce902ec181a799d8d1f040e8cc39af6.1567047549.git.brandonbonaby94@gmail.com>
 <DM5PR21MB0137F04798C30379AD6CE553D7BE0@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR21MB0137F04798C30379AD6CE553D7BE0@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 02, 2019 at 06:31:04PM +0000, Michael Kelley wrote:
> From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Wednesday, August 28, 2019 9:24 PM
> > 
> > Introduce user specified latency in the packet reception path
> > By exposing the test parameters as part of the debugfs channel
> > attributes. We will control the testing state via these attributes.
> > 
> > Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> > ---
> > diff --git a/Documentation/ABI/testing/debugfs-hyperv
> > b/Documentation/ABI/testing/debugfs-hyperv
> > new file mode 100644
> > index 000000000000..0903e6427a2d
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/debugfs-hyperv
> > @@ -0,0 +1,23 @@
> > +What:           /sys/kernel/debug/hyperv/<UUID>/fuzz_test_state
> > +Date:           August 2019
> > +KernelVersion:  5.3
> 
> Given the way the timing works for adding code to the Linux kernel,
> the earliest your new code will be included is 5.4.  The merge window
> for 5.4 will open in two weeks, so your code would need to be accepted
> by then to be included in 5.4.  Otherwise, it won't make it until the next
> merge window, which would be for 5.5.  I would suggest changing this
> (and the others below) to 5.4 for now, but you might have to change to
> 5.5 if additional revisions are needed.
> 

I see, I'll keep this in mind when submitting the further revisions
thanks

> > diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> > index a1eec7177c2d..d754bd86ca47 100644
> > --- a/drivers/hv/Makefile
> > +++ b/drivers/hv/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
> >  obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
> >  obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
> > +obj-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
> 
> There's an additional complexity here that I failed to describe to
> you in my previous comments.  :-(    The above line makes the
> hv_debugfs code part of the main Linux OS image -- i.e., the
> vmlinuz file that gets installed into /boot, such that if hv_debugfs
> is built, it is always loaded into the memory of the running system.
> That's OK, but we should consider the alternative, which is to
> make the hv_debugfs code part of the hv_vmbus module that
> is specified a bit further down in the same Makefile.   A module
> is installed into /lib/modules/<kernel version>/kernel, and
> is only loaded into memory on the running system if something
> actually references code in the module.  This approach helps avoid
> loading code into memory that isn't actually used.
> 
> Whether code is built as a separate module or is just built into
> the main vmlinuz file is also controlled by the .config file setting.
> For example, CONFIG_HYPERV=m says to treat hv_vmbus as a
> separate module, while CONFIG_HYPERV=y says to build the
> hv_vmbus module directly into the vmlinuz file even though the
> Makefile constructs it as a module.
> 
> Making hv_debugfs part of the hv_vmbus module is generally better
> than just building it into the main vmlinuz because it's best to include
> only things that must always be present in the main vmlinuz file.
> hv_debugfs doesn't have any reason it needs to always be present.
> By comparison, hv_balloon is included in the main vmlinuz, which
> might be due to it dealing with memory mgmt and needing to be
> in the vmlinuz image, but I'm not sure.
> 
> You can make hv_debugfs part of the hv_vmbus module with this line
> placed after the line specifying hv_vmbus_y, instead of the line you
> currently have:
> 
> hv_vmbus-$(CONFIG_HYPERV_TESTING)       += hv_debugfs.o
> 

Ah, I see now. That makes sense I'll go ahead and make the adjustments

thanks

> > +
> > +static int hv_debugfs_delay_set(void *data, u64 val)
> > +{
> > +	int ret = 0;
> > +
> > +	if (val >= 1 && val <= 1000)
> > +		*(u32 *)data = val;
> > +	else if (val == 0)
> > +		*(u32 *)data = 0;
> 
> I think this "else if" clause can be folded into the first
> "if" statement by just checking "val >= 0".
> 

good call, I'll fold it into one statement 

> 
> > +/* Remove dentry associated with released hv device */
> > +void hv_debug_rm_dev_dir(struct hv_device *dev)
> > +{
> > +	if (!IS_ERR(hv_debug_root))
> > +		debugfs_remove_recursive(dev->debug_dir);
> > +}
> 
> This function is the first of five functions that are called by
> code outside of hv_debugfs.c.   You probably saw the separate
> email from the kbuild test robot showing a build error on each
> of these five functions.  Here's why.
> 
> When CONFIG_HYPERV=m is set, and hv_vmbus is built as a
> module, there are references to the five functions from the
> module to your hv_debugfs that is built as core code in
> vmlinuz.  By default, Linux does not allow such core code to
> be called by modules.   Core code must add a statement like:
> 
> EXPORT_SYMBOL_GPL(hv_debug_rm_dev_dir);
> 
> to allow the module to call it.   This gives the code writer
> a very minimal amount of scope control.  However, if you build 
> hv_debugfs as part of the module hv_vmbus, and the only
> references to the five functions are within the module hv_vmbus,
> then the EXPORT statements aren't needed because all
> references are internal to the hv_vmbus module.  But if
> you envision a function like hv_debug_delay_test() being
> called by other Hyper-V drivers that are outside the
> hv_vmbus module, then you will need the EXPORT statement
> at least for that function.
> 
> You probably have your .config file setup with
> CONFIG_HYPERV=y.  In that case, the hv_vmbus module is
> built-in to the kernel, so you didn't get the errors reported
> by the kbuild test robot.  When testing new code, it's a
> good practice to build with the HYPERV settings set to
> 'm' to make sure that any issues with module references
> get flushed out and fixed.
> 
> Michael

Oh I see, I'll test it out as a module so I can fix this. As for
exporting hv_debug_delay_test() It might come in handy later but
I think for now I should focus on just the ones in the hv_vmbus
module for now. 

thanks
